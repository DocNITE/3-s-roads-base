#==============================================================================
# ** Detect enter location
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This enter location script file                     
#==============================================================================

def rm_s_dialog
    callMsg("Tavern_3_roads:TavernStreet/RoadMap");

    case $game_temp.choice
     when 1
        callMsg("Tavern_3_roads:TavernStreet/RoadMap_Dialog1");
        rm_s_dialog
    when 2
        callMsg("Tavern_3_roads:TavernStreet/RoadMap_Dialog2");
        rm_s_dialog
    when 3
        callMsg("Tavern_3_roads:TavernStreet/RoadMap_Dialog3");
        rm_s_dialog
    end
end
rm_s_dialog

$game_temp.choice = -1