#==============================================================================
# ** Detect enter location
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This enter location script file                     
#==============================================================================

callMsg("Convoy:Convoy/OvermapEnter");

case $game_temp.choice
 when 1
	$game_player.direction = 2
    change_map_enter_tagLevel(Z_FFC_CONVOY_MAP);
end

$cg.erase
portrait_hide
chcg_background_color_off

$game_portraits.lprt.hide
$game_portraits.rprt.hide
$game_temp.choice = -1