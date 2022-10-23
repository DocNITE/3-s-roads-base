#==============================================================================
# ** Enemy bar
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain object                  
#==============================================================================

ViewSDK::TEXTURE_PATH = "#{Z_MOD_FOLDER}tex/"
module EnemyBar
    
    ENEMY_HP_DRAW = CDraw.new(CVector2.new(120, 14), "", 1122)
    LINE = CTexture.new(Rect.new(0, 8, 104, 2), "bar", 1122)
    ENEMY_HP_ELEMENT_PROGRESS = CTexture.new(Rect.new(0, 4, 104, 4), "bar", 1122)
    ENEMY_HP_ELEMENT_BACK = CTexture.new(Rect.new(104, 4, 104, 4), "bar",  1121)
    ENEMY_BAR = CStatusBar.new(100, 100, ENEMY_HP_ELEMENT_PROGRESS, ENEMY_HP_ELEMENT_BACK, 1120);

    def self.init()
        newFont = Font.new()
        newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont.bold = true
        newFont.size = 15
        newFont.outline = true
        newFont.color = Color.new(245, 213, 39, 255);

        LINE.setPosition(0, -4)
        ENEMY_BAR.addChild(LINE);

        ENEMY_HP_DRAW.font = newFont;
        ENEMY_HP_DRAW.text = "100.0%";
        ENEMY_HP_DRAW.setPosition(0, -18)

        ENEMY_BAR.addChild(ENEMY_HP_DRAW);

        ENEMY_BAR.setPosition(416, 300)
        ENEMY_BAR.setVisible(false);
    end

    def self.hide()
        ENEMY_BAR.setVisible(false);
    end

    def self.show()
        ENEMY_BAR.setVisible(true);
        #ENEMY_HP_DRAW.setVisible(true);
    end

    def self.setValue(val)
        ENEMY_BAR.setValue(val);
    end

    def self.setMaxValue(val)
        ENEMY_BAR.setMaxValue(val);
    end
end
EnemyBar.init()

$e_b_timer = 0;
$e_b_timer_toggle = false;
class Map_Hud
  
    alias map_hud_renderer refresh
	def refresh
        map_hud_renderer
		
        if @viewport.visible
            if $e_b_timer_toggle == false
                return
            end

            if $e_b_timer < 300
                EnemyBar.show();
                $e_b_timer += 1
            else
                EnemyBar.hide();
                $e_b_timer_toggle = false;
                $e_b_timer = 0;
            end
        end
	end
end

module Battle_System
    def take_damage(user,skill,force_hit=false,back_stabed=false)
		@accumulated_damage=0
		skill_blocked=blocked?(user)
		advantaged = back_stabed
		user.totalTargetedUnit += 1 if skill.hit_DecreaseDamage
		skill.effect.each{|eff|
			skill_effect=user.get_affected_attr(eff.base)
			receive_eff=get_affected_attr(eff.compare)
			#如果有被擋住，處理述職的buff或debuff
			if !@skill.nil? && (skill_blocked && !skill.no_parry)
				@skill.effect.each{
					|blocker|
					if blocker.base.attr.eql?(eff.compare.attr)
						case blocker.base.type
							when "+" ;receive_eff+=blocker.base.adjust;
							when "-" ;receive_eff-=blocker.base.adjust;
							when "*" ;receive_eff*=blocker.base.adjust;
							when "/" ;receive_eff/=blocker.base.adjust;
						end				
					end
				}
			else
				cancel_holding if !skill.no_action_change && !actor_skill_no_interrupt?
			end
			##OLD MODE
			#line=skill.hit_detection.calc_sight_hp_and_dist(user.map_token,self.map_token)
			#shp_left=line[0]
			
			#TT MODE
			line = [1-($game_map.terrain_tag(self.map_token.x,self.map_token.y)*0.25),0].max
			shp_left= 10*line
			if force_hit
				mine_value = 1
				ratio = 1
			else
				mine_value=skill.hit_detection.mine_number(user.map_token,self.map_token,false)
				return set_action_state(:none) if mine_value.nil?
				ratio=shp_left.to_f/ skill.hit_detection.sight_hp
			end
			
			#skill_effect = exportResultWithMultiHitDecrease(skill_effect,user) if skill.hit_DecreaseDamage
			result=((skill_effect-receive_eff)* ratio * mine_value).to_i
			result=1 if result < 1 || (skill_blocked && !skill.no_parry)
			result = (result*= skill.back_stab).to_i if advantaged
			result = exportResultWithMultiHitDecrease(result,user) if skill.hit_DecreaseDamage
			
			#計算實際影響後的attribute數值
			attribute= battle_stat.get_stat(eff.damage.attr,eff.damage.attr_type)
			battle_stat.set_stat(eff.damage.attr,get_affected_damage(eff,attribute,result),eff.damage.attr_type)
			#DEBUG用，用完記得刪，找到正確地點後移除。
			if hit_LinkToMaster && master.actor.action_state !=:death
				attribute = master.actor.battle_stat.get_stat(eff.damage.attr,eff.damage.attr_type)
				master.actor.battle_stat.set_stat(eff.damage.attr,get_affected_damage(eff,attribute,result),eff.damage.attr_type)
				$game_damage_popups.add(result, master.x, master.y, user.map_token.direction,eff.popup_type) if self.map_token != user.map_token #&& eff.popup_type !=0 #None
			elsif self.map_token != user.map_token #&& eff.popup_type !=0 #None
                $e_b_timer_toggle = true
                $e_b_timer = 0;
                EnemyBar.setMaxValue(self.map_token.actor.battle_stat.get_stat("health", 2)); 
                EnemyBar.setValue(self.map_token.actor.battle_stat.get_stat("health")); 
                EnemyBar::ENEMY_HP_DRAW.text = "#{((EnemyBar::ENEMY_BAR.value/EnemyBar::ENEMY_BAR.max_value)*100).to_i}%"
				$game_damage_popups.add(result, self.map_token.x, self.map_token.y, user.map_token.direction,eff.popup_type)
			end
		}
	end
end

class Game_SandboxObject < Game_DestroyableObject
	
	def take_damage(user,skill,force_hit=false)
		@accumulated_damage=0
		skill_blocked=blocked?(user)
		advantaged = (skill.back_stab && back_stab?(user)) #自己被 stun 或back_stab?
		user.totalTargetedUnit += 1
		skill.effect.each{|eff|
			skill_effect=user.get_affected_attr(eff.base)
			receive_eff=get_affected_attr(eff.compare)
	
			line = [1-($game_map.terrain_tag(self.map_token.x,self.map_token.y)*0.25),0].max
			shp_left= 10*line
			if force_hit
				mine_value = 1
				ratio = 1
			else
				mine_value=skill.hit_detection.mine_number(user.map_token,self.map_token,false)
				return set_action_state(:none) if mine_value.nil?
				ratio=shp_left.to_f/ skill.hit_detection.sight_hp
			end
            
            $e_b_timer_toggle = true
            $e_b_timer = 0;
            EnemyBar.setMaxValue(self.map_token.actor.battle_stat.get_stat("health", 2)); 
            EnemyBar.setValue(self.map_token.actor.battle_stat.get_stat("health")); 
            EnemyBar.ENEMY_HP_DRAW.text = "#{(ENEMY_BAR.value/ENEMY_BAR.max_value)*100 + 0.0}%"
	
			#skill_effect = exportResultWithMultiHitDecrease(skill_effect,user) if skill.hit_DecreaseDamage
			result=((skill_effect-receive_eff)* ratio * mine_value).to_i
			result=1 if result < 1 || (skill_blocked && !skill.no_parry)
			result = (result*= skill.back_stab).to_i if advantaged
			result = exportResultWithMultiHitDecrease(result,user) if skill.hit_DecreaseDamage
	
			if self.map_token != user.map_token #&& eff.popup_type !=0 #None
				$game_damage_popups.add(result, self.map_token.x, self.map_token.y, user.map_token.direction,eff.popup_type)
			end
		}
	end
end
