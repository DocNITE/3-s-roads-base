# Диалог с Володимером
# "3S: FIRST_ENTER_IN_TAVERN"

def volodimer_t_first_dlg
	if $story_stats["3S: volodiaFirstTalk"] == 0
    	callMsg("Tavern_3_roads:Volodimer/FirstMeeting1");
		$story_stats["3S: volodiaFirstTalk"] = YES
	else
		callMsg("Tavern_3_roads:Volodimer/FirstMeeting_rand#{rand(3)+1}");
	end
end

def volodimer_t_dlg
    #callMsg("Tavern_3_roads:Volodimer/FirstMeeting2");
end

if $story_stats["3S: FIRST_ENTER_IN_TAVERN"] == NO
	volodimer_t_first_dlg
else
	volodimer_t_dlg
end

$bg.erase;
cam_center(0);
$game_temp.choice = -1;