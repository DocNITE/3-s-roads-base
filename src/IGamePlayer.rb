#==============================================================================
# ** Inject in Game_Player class
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

# Inject
class Game_Player < Game_Character

  #--------------------------------------------------------------------------
  # * Execute Player Transfer
  #--------------------------------------------------------------------------
  def perform_transfer
    if transfer?
      set_direction(@new_direction)
      if @new_map_id != $game_map.map_id
		if @new_map_id > 13000
        	$game_map.customSetup(@new_map_id-13000)
		else
			$game_map.setup(@new_map_id)
		end
        $game_map.autoplay
		Cache.clear_chs(true) #清掉除Lona以外所有組好的chs腳色
      end
      moveto(@new_x, @new_y)
      clear_transfer_info
    end
  end
end

#module GIM_ADDON

#end

#Load log
#tlog("[OHR]: Script succefull loaded...");