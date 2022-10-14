#==============================================================================
# ** Inject in Game_Map class & add new map setup function
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#inject
class Game_Event < Game_Character

	def batch_world_map_addon
    end

end

module GIM_OM

    def standartNap(type=:normal,map_id=$game_map.map_id,*param)
        $game_pause = true
        chcg_background_color(0,0,0,0,7)
        screen.start_tone_change(Tone.new(0,0,0,0),0)
        $game_portraits.lprt.hide
        $game_player.release_chs_group
        call_msg("common:Lona/nap") if !$game_map.isOverMap
        $game_map.pre_nap  
        $game_map.nap						#處理game_map相關的內容，像是主角重新設置事件、主角留在定位等。
        $game_player.actor.process_nap_change
        $game_map.customSetup(map_id)
        case type
            when :normal;
                tgtx=$game_player.x
                tgty=$game_player.y
            when :transport
                tgtx,tgty=param
            when :point;
                tgtx,tgty=$game_map.get_storypoint(param[0])
            when :region;
                tgtx,tgty=$game_map.get_random_region(param[0])
        end
        $game_player.moveto(tgtx,tgty)
        SceneManager.scene.dispose_spriteset #test
        SceneManager.scene.create_spriteset
        $game_map.refresh #因為nap必須保留部分事件不重新初始化，所以需要額外呼叫一次refresh來讓事件翻頁功能正常運作
        Cache.clear_chs_material(true) #Cache.clear
        $game_map.aft_nap
        check_wakeup_event
        wait_for_message
        $game_pause = false
        achCheckDate
    end

end