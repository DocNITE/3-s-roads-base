# Диалог с догниггерским котом

GabeSDK.getAchievement("THIRDS_NecoDocFirst");

if $story_stats["3S: NEKO_DOC_SCORE"] == 0 
	$story_stats["3S: NEKO_DOC_SCORE"] = 0
end

# Надо крч сюда звуки мяумура добавить когда гладишь
# А еще миниигру под тему некоарк, где ты чешишь кота под спидран
# Мышкой так водишь по головке. Зажимая расческу.
# И зарабатываешь очки и бьешь рекорды

def cat_t_no_mouseController_dlg
	callMsg("CatDlg:Cat/MiniGameNoMouse")
end


def cat_t_minigame_play
	SndLib.bgm_stop;
	callMsg("CatDlg:Cat/MiniGameRulesOfNature")
	SndLib.cursed;
	G_NekoPet.init()
	G_NekoPet.enable();
	#G_NekoPet.wait_when_end
	wait(150*60)
	SndLib.bgm_stop;
	cat_t_minigame_end
end
def cat_t_minigame_end
	if $story_stats["3S: NEKO_DOC_SCORE"] < G_NekoPet.getScore()
		$story_stats["3S: NEKO_DOC_SCORE"] = G_NekoPet.getScore();
	end
	#msgbox $story_stats["3S: NEKO_DOC_SCORE"]
	G_NekoPet.disable();
	wait(120);
	#callMsg("CatDlg:Cat/MiniGameEnd")
	call_msg("\\narr #{getTextInfo("CatDlg:Cat/MiniGameEnd")} #{$story_stats["3S: NEKO_DOC_SCORE"]}")
	SndLib.tavern_warcraft(80, 100);
end

def cat_t_dlg
    callMsg("CatDlg:Cat/417CURSEDTHEME");

	case $game_temp.choice
	when 1
		SndLib.meow;
		cat_t_dlg
	when 2
		if !Mouse.usable?
			cat_t_no_mouseController_dlg
		else
			cat_t_minigame_play
		end
	end
end
cat_t_dlg

$bg.erase;
cam_center(0);
$game_temp.choice = -1;