
# for mod's text
def callMsg(fileName)
    case $lang
        when "ENG"
            call_msg( "../../" + Z_MOD_FOLDER + "text/ENG/" + fileName)
        when "RUS"
            #call_msg( "../../" + Z_MOD_FOLDER + "text/RUS/" + fileName)
            call_msg( "../../" + Z_MOD_FOLDER + "text/ENG/" + fileName)
        else
            call_msg( "../../" + Z_MOD_FOLDER + "text/ENG/" + fileName)
    end
end

#for popup player msg
def callInfoPopup(text)
    SndLib.sound_QuickDialog
	$game_map.popup(0,text,0,0);
end