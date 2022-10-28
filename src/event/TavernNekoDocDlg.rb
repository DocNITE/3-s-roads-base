# Диалог с догниггерским котом

GabeSDK.getAchievement("THIRDS_NecoDocFirst");

# Надо крч сюда звуки мяумура добавить когда гладишь
# А еще миниигру под тему некоарк, где ты чешишь кота под спидран
# Мышкой так водишь по головке. Зажимая расческу.
# И зарабатываешь очки и бьешь рекорды
def cat_t_dlg
    callMsg("CatDlg:Cat/417CURSEDTHEME");

	case $game_temp.choice
	when 1
		SndLib.meow;
	when 2
		callMsg("CatDlg:Cat/417CURSEDTHEME2");
		SndLib.cursed;
	end
end
cat_t_dlg

$bg.erase;
cam_center(0);
$game_temp.choice = -1;