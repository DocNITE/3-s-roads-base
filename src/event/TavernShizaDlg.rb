# Диалог с Шиз'а
# ["3S: SHIZA_FIRST_MEETING",   NO],  -- первая встреча с шизой

=begin
Надо сделать шизу королем диско
https://www.youtube.com/watch?v=65DvwmpKpek&list=PLzdCHbYwU4y4ZRccRSUIW2oics33ylJsO&index=15
=end

def shiza_t_first_dlg
    callMsg("ShizaDlg:Shiza/FirstMeeting");
end

def shiza_t_dlg
    #callMsg("Tavern_3_roads:Shiza/FirstMeeting");
end

if $story_stats["3S: SHIZA_FIRST_MEETING"] == NO
	shiza_t_first_dlg
	$story_stats["3S: SHIZA_FIRST_MEETING"] = YES;
else
	shiza_t_dlg
end

$bg.erase;
cam_center(0);
$game_temp.choice = -1;