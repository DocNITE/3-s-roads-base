#-----------------------------------------------------------------------------------------------------
# * Tavern nap system
#    Leave func     :   change_map_tag_subLevel(Z_TAVERN_STREET_MAP, "StartPoint2", 2)
#-----------------------------------------------------------------------------------------------------
#    Check key      :   $game_party.has_item?("ItemNoerTavernNapKey")
#           Or          $game_party.has_item?($data_items[106])
#-----------------------------------------------------------------------------------------------------
#    Sleep script   :   $game_party.lose_item($data_items[106], 1)
#                       $game_player.actor.health =$game_player.actor.attr_dimensions["health"][2]
#               		$game_player.actor.sta =$game_player.actor.attr_dimensions["sta"][2]
#               		$game_player.actor.sat =$game_player.actor.attr_dimensions["sat"][2]
#               		4.times{load_script("Data/Batch/Command_Bath.rb")}
#               		$game_player.actor.dirt =0
#               		handleNap
#-----------------------------------------------------------------------------------------------------

if $game_party.has_item?("3S_ItemTavernKey")
    $game_party.lose_item($data_ItemName["3S_ItemTavernKey"], 1)
    $game_player.actor.health =$game_player.actor.attr_dimensions["health"][2]
    $game_player.actor.sta =$game_player.actor.attr_dimensions["sta"][2]
    $game_player.actor.sat =$game_player.actor.attr_dimensions["sat"][2]
    4.times{load_script("Data/Batch/Command_Bath.rb")}
    $game_player.actor.dirt =0
    point=$game_map.get_storypoint("WakeUp")
    standartNapOnPos(point[0], point[1]);
else
    callMsg("Tevern_3_roads_main:Tavern/Kicked")
	portrait_hide
    #change_map_leave_tag_map
	change_map_tag_subLevel(Z_TAVERN_STREET_MAP, "StartPoint2", 2, true, true)
end