#==============================================================================
# ** Inject in Game_Map class & add new map setup function
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#inject
class Game_Map

    #Doc edit:
    #  Add alter. setup func
    def customSetup(map_id)
        @starting_events=[] #remove starting events from previous map. Fixes crash when moving from sewers to OrkindCave1 #antiLag
		@cam_target = 0
		Cache.clear_chs_character
		prp "setting up map id=>#{map_id}",6
		nap = (@map_id==map_id  && !@force_setup)#用目標地圖是否與當下所在地圖id香等來判斷
		@threat =false
		save_overmap_char if @isOverMap
		prp "Game_Map :nap =>#{nap}, @map_id==map_id =>#{@map_id==map_id} , @force_setup=>#{@force_setup}"
		@map_id = map_id
		@map = load_data("ModScripts/_Mods/" + Z_MOD_NAME + "/data/Map" + @map_id.to_s + ".rvdata2");
		@tileset_id = @map.tileset_id
		@display_x = 0
		@display_y = 0
		#@npcs = Array.new if !nap
		#referesh_vehicles
		@turn_based=nil
		prp "$game_map.setup_storypoint_map",6
		setup_storypoint_map
		prp "$game_map.setup_region_map",6
		setup_region_map
		prp "$story_stats.reset_chars during Game_Map.setup",6
		$story_stats.reset_chars
		prp "$game_map.setup_events",6
		nap ? reset_events : setup_events 
		prp "$game_map.setup_overmap",6
		setup_overmap
		prp "$game_map.setup_scroll",6
		setup_scroll
		prp "$game_map.setup_parallax",6
		setup_parallax
		prp "$game_map.setup_battleback",6
		setup_battleback
		@need_refresh = false
		@force_setup = false 
		@scroll_blocked = false
		reload_events_into_pos_hash
		prp "$game_map.setup finish",6
    end

    alias ffc_setup_overmap setup_overmap
	def setup_overmap
        ffc_setup_overmap

        # Check, if player enter on overmap
		if @isOverMap
			callEvent("OnOvermapEnter", []);
        end
    end
end

def change_map_enter_tagLevel(force_id=0)		#主動進入TAG MAP
	#$game_party.lose_gold($game_party.gold)
	$story_stats["LastOverMapX"] = $game_player.x
	$story_stats["LastOverMapY"] = $game_player.y
	change_map_weather_cleaner
	if force_id != 0
		p "change_map_enter_tag way2 force_id => #{force_id}"
		$game_player.reserve_transfer(force_id+13000, 1,1,$game_player.direction)
	end
	change_map_story_stats_fix
end

def change_map_enter_tagSubLevel(target=nil)		#進入Submap
	SndLib.me_play("SE/Move",75,120+rand(31))
	call_timer_off
	$game_timer.update
	#$game_party.lose_gold($game_party.gold)
	change_map_weather_cleaner
	p "change_map_enter_tagSub rnd_map_id => #{target}"
	$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear #一定要比換地圖早
	$game_player.reserve_transfer(target+13000, 1,1,$game_player.direction)
	change_map_story_stats_fix
end

def change_map_captured_enter_tagSubLevel(target=nil)		#進入Submap
	SndLib.me_play("SE/Move",75,120+rand(31))
	call_timer_off
	#$game_party.lose_gold($game_party.gold)
	change_map_weather_cleaner
	p "change_map_enter_tagSub rnd_map_id => #{target}"
	$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear #一定要比換地圖早
	$game_player.reserve_transfer(target+13000, 1,1,$game_player.direction)
	change_map_captured_story_stats_fix
end

def change_map_tag_subLevel(tmpTar,tmpPoint=0,tmpDir=0,tmpChoice=true,tmpSkipOpt=false,capture=false)
	return SndLib.sys_buzzer if $game_player.cannot_ChangeMap
	if !tmpSkipOpt
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
			return
		else
			call_msg("common:Lona/EnterSub")
		end
	else
		$game_temp.choice = 1
	end
	
	if $game_temp.choice == 1
		$game_temp.choice =0 if tmpChoice
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		else
			chcg_background_color(0,0,0,0,14)
			$story_stats["TagSubTrans"] = tmpPoint if tmpPoint != 0
			$story_stats["TagSubForceDir"] = tmpDir if tmpDir != 0
			change_map_enter_tagSubLevel(tmpTar) if !capture
			change_map_captured_enter_tagSubLevel(tmpTar) if capture
		end
	end
end