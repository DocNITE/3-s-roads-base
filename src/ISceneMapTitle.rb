#==============================================================================
# ** Inject in Game_Map class & add new map setup function
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#inject
=begin

So, that custom title menu.
I disabled it. Maybe enable later

class Scene_MapTitle < Scene_Map
	attr_accessor   :character_name           # character graphic filename
	attr_accessor   :character_index          # character graphic index
	def start
		$loading_screen.dispose if $loading_screen
		if $titleCreateActorReq == true
			Cache.clear
			DataManager.create_game_objects
			DataManager.setup_new_game(false)
			$hudForceHide = true
			$balloonForceHide = true
			#tmpPickID = Array.new  #TitleCustom
			#tmpPickID << "TitleMarket"
			#tmpPickID << "TitleMarketDed" 		if DataManager.get_rec_constant("RecEndLeaveNoer") == 1 && !$DEMO
			#tmpPickID << "Title666"				if DataManager.get_rec_constant("RecEndLeaveNoer") == 1 && !$DEMO
			
			#tmpPickID = tmpPickID.sample
			#rnd_map_id = $data_tag_maps[tmpPickID].sample
			$game_map.customSetup(Z_TITLE_SCREEN_MAP)
			$game_player.moveto(59,55)
			$game_portraits.lprt.hide
			$game_portraits.rprt.hide
			$game_player.force_update = false
			$game_system.menu_disabled = true
			$titleCreateActorReq = false
			Graphics.frame_count = 0
			#SndLib.bgm_play("../../ModScripts/Graveyard");
		end
		super
		@hud.hide
		@menu = TitleMenu.new
	end

end
=end

if Z_DEBUG
    class TitleMenu < Sprite
        
        
        def handlerCmdNewGame(value)
            return if @onBegin == true
            SndLib.closeChest
            $titleCreateActorReq = true
            $game_map.customSetup(Z_TAVERN_STREET_MAP)
            position_start_p = $game_map.get_storypoint("StartPoint");
            $game_player.moveto(position_start_p[0], position_start_p[1]);
            $game_map.interpreter.new_game_GetCommonSkills ##29_Functions_417
            $game_player.actor.learn_skill(63)
            $hudForceHide = false
            $balloonForceHide = false
            SceneManager.scene.fadeout_all
            SceneManager.prevOptChooseSet(nil)
            SceneManager.prevTitleOptChooseSet(nil)
            #$game_map.interpreter.change_map_weather_cleaner
            $game_player.force_update = true
            $game_system.menu_disabled = false
            SceneManager.goto(Scene_Map)
        end

    end
end