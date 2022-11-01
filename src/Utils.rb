# Add text buffer
module TextCache
    #--------------------------------------------------------------------------
    # * Check Cache Existence
    #--------------------------------------------------------------------------
    def self.include?(key)
        @cache[key] && !@cache[key].nil?
    end
    #--------------------------------------------------------------------------
    # * Txt info
    #--------------------------------------------------------------------------
    def self.txt_info(path, file, title)
        @cache ||={}
        @cache[path] = Text.new(path) unless include?(path)
        @cache[path]["#{file}:#{title}"]
    end
end

# for mod's text
def callMsg(fileName, bg=0,pos=2,wait_pull=1)
    case $lang
        when "ENG"
            call_msg("../../" + Z_MOD_FOLDER + "text/ENG/" + fileName, bg,pos,wait_pull)
        when "RUS"
            #call_msg( "../../" + Z_MOD_FOLDER + "text/RUS/" + fileName)
            call_msg("../../" + Z_MOD_FOLDER + "text/RUS/" + fileName, bg,pos,wait_pull)
        else
            call_msg("../../" + Z_MOD_FOLDER + "text/ENG/" + fileName, bg,pos,wait_pull)
    end
end

#for popup player msg
def callInfoPopup(fileName)
    SndLib.sound_QuickDialog
	case $lang
        when "ENG"
            call_msg_popup("../../" + Z_MOD_FOLDER + "text/ENG/" + fileName)
        when "RUS"
            #call_msg( "../../" + Z_MOD_FOLDER + "text/RUS/" + fileName)
            call_msg_popup("../../" + Z_MOD_FOLDER + "text/RUS/" + fileName)
        else
            call_msg_popup("../../" + Z_MOD_FOLDER + "text/ENG/" + fileName)
    end
end

#Get info from text file
def getTextInfo(_info)
    fileName    = _info.split(':')[0];
    title       = _info.split(':')[1];
    case $lang
        when "ENG"
            return TextCache.txt_info(Z_MOD_FOLDER + "text/ENG", fileName, title)
        when "RUS"
            return TextCache.txt_info(Z_MOD_FOLDER + "text/RUS", fileName, title)
        else
            return TextCache.txt_info(Z_MOD_FOLDER + "text/ENG", fileName, title)
    end
end