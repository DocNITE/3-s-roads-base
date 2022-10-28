
#GabeSDK.getAchievement("name");
#Для будущих версий надо будет все переделать.
#------------------------------------------------------------------
# * New Achievements
#------------------------------------------------------------------
GabeSDK::AchievementsData[:THIRDS_FirstMeeting] = [DataManager.get_constant("ACH","THIRDS_FirstMeeting",1), 1, false];
GabeSDK::AchievementsData[:THIRDS_NecoDocFirst] = [DataManager.get_constant("ACH","THIRDS_NecoDocFirst",1), 1, false];





def restoreAchievements()
    GabeSDK.removeAchievement("THIRDS_FirstMeeting");
end

#Inject
module GabeSDK
    def self.getAchievement(ach_id)
		ach_idSYM = ach_id.to_sym
		return if !AchievementsData[ach_idSYM]
		return if AchievementsData[ach_idSYM][0] >= AchievementsData[ach_idSYM][1]
		AchievementsData[ach_idSYM][0] = AchievementsData[ach_idSYM][1]
		DataManager.write_constant("ACH",ach_id,AchievementsData[ach_idSYM][1])
        local_is3s = ach_id.split('_')
        tmpName = -1;
        if local_is3s[0] == "THIRDS"
		    tmpName =  getTextInfo("DataACH:#{ach_id}/item_name")
        else
            tmpName =  $game_text["DataACH:#{ach_id}/item_name"]
        end
		SceneManager.scene.achievementGet(tmpAchName=tmpName,tmpIcon=ach_id)
	end
end

#Inject
class Scene_Base
def achievementPopup(tmpTop="",tmpBot="",tmpTime=300,achIcon=nil)
    @tmpSprite.dispose if @tmpSprite
    tmpGW = Graphics.width/3
    tmpGH = Graphics.height/3
    @achNeedUpdate = true
    @achTime = tmpTime
    @tmpSprite=Sprite.new
    @tmpSprite.bitmap	=Bitmap.new(tmpGW,tmpGH)
    @tmpSprite.x = 5+Graphics.width/2 - tmpGW/2
    @tmpSprite.y = -50
    @tmpSprite.z = System_Settings::SCENE_AchievementPopup_Z
    @tmpSprite.bitmap=Bitmap.new("Graphics/System/AchUlk.png")
    local_is3s = achIcon.split('_')
    if local_is3s[0] == "THIRDS"
        @tmpSprite.bitmap.blt(5 , 5 ,Bitmap.new("#{Z_MOD_FOLDER}tex/ACH/#{achIcon}.png"),Rect.new(0, 0, 32, 32)) if achIcon
    else
        @tmpSprite.bitmap.blt(5 , 5 ,Bitmap.new("Graphics/System/ACH/#{achIcon}.png"),Rect.new(0, 0, 32, 32)) if achIcon
    end
    @tmpSprite.bitmap.font.size = 16
    @tmpSprite.bitmap.font.bold = true
    @tmpSprite.bitmap.font.outline = false
    @tmpSprite.bitmap.font.color=Color.new(255,255,0,255)
    @tmpSprite.bitmap.draw_text(16,-2, tmpGW,25,tmpTop,1)
    @tmpSprite.bitmap.font.size = 18
    @tmpSprite.bitmap.font.color=Color.new(125,255,0,255)
    @tmpSprite.bitmap.draw_text(16,17, tmpGW,25,tmpBot,1)
end
end

#inject
class AchListMenu < Sprite

	def buildACHline(tmpName,tmpIndex,tmpUnlocked,tmpAchNum)
		tmpUnlocked ? tmpOPA = 255 : tmpOPA = 125
		tmpUnlocked ? tmpIconOPA = 255 : tmpIconOPA = 75
		if !tmpName
			tmpBMP = Bitmap.new("Graphics/System/ACH/Hidden.png")
			tmpNameText = "?????"
			tmpDespText = "??????????????????????"
			tmpProg = "???"
		else
            local_is3s = tmpName.split('_')
            if local_is3s[0] == "THIRDS"
                tmpBMP = Bitmap.new("#{Z_MOD_FOLDER}tex/ACH/#{tmpName}.png")
                @achData[tmpName.to_sym][1] > 1 ? tmpProg = "#{@achData[tmpName.to_sym][0]} / #{@achData[tmpName.to_sym][1]}" : tmpProg = ""
                tmpNameText = "#{getTextInfo("DataACH:#{tmpName}/item_name")}      #{tmpProg}"
                tmpDespText = getTextInfo("DataACH:#{tmpName}/description")
            else
                tmpBMP = Bitmap.new("Graphics/System/ACH/#{tmpName}.png")
                @achData[tmpName.to_sym][1] > 1 ? tmpProg = "#{@achData[tmpName.to_sym][0]} / #{@achData[tmpName.to_sym][1]}" : tmpProg = ""
                tmpNameText = "#{$game_text["DataACH:#{tmpName}/item_name"]}      #{tmpProg}"
                tmpDespText = $game_text["DataACH:#{tmpName}/description"]
            end
		end
		@achBitmap.bitmap.blt(35 , 5+tmpIndex*@eachIndexPX ,tmpBMP,Rect.new(0, 0, 32, 32),opacity = tmpIconOPA)
		@achBitmap.bitmap.font.bold = true
		@achBitmap.bitmap.font.outline = false
		@achBitmap.bitmap.font.name = Font.default_name
		@achBitmap.bitmap.font.size = 24
		@achBitmap.bitmap.font.color.set(255,255,255,tmpOPA)
		@achBitmap.bitmap.draw_text(0, 7+tmpIndex*@eachIndexPX,@achBitmapGW,25,"#{tmpAchNum} :",0)
		@achBitmap.bitmap.font.bold = false
		@achBitmap.bitmap.font.color.set(255,255,255,tmpOPA)
		@achBitmap.bitmap.font.size = 20
		@achBitmap.bitmap.draw_text(80, tmpIndex*@eachIndexPX,@achBitmapGW,25,tmpNameText,0)
		@achBitmap.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		@achBitmap.bitmap.font.color.set(255,255,255,tmpOPA)
		@achBitmap.bitmap.font.size = 14
		@achBitmap.bitmap.draw_text(80, 18+tmpIndex*@eachIndexPX,@achBitmapGW,25,tmpDespText,0)
		
	end
end