# Диалог с Диком

def dick_t_first_dlg
    callMsg("Tavern_3_roads:Dick/FirstMeeting");
end

def dick_t_dlg
    #callMsg("Tavern_3_roads:Shiza/FirstMeeting");
end

if $story_stats["3S: dickFirstMeeting"] == 0
	dick_t_first_dlg
	$story_stats["3S: dickFirstMeeting"] = YES;
else
	dick_t_dlg
end

$bg.erase;
cam_center(0);
$game_temp.choice = -1;