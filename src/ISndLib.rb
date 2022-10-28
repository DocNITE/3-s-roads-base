#==============================================================================
# ** Inject in SoundsLibrary & add new sound func
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#Inject in lib module
module SndLib

    #Doc edit:
    #def self.horse_footstep(vol = rand(20)+60, effect = rand(20)+50)
    #    Audio.se_play("ModScripts/_Mods/OverMap Horse Riding/snd/horse_footstep.ogg",vol,effect)
    #end

    # MAIN BGM/BGS PLAYER:
    def self.bgmPlay(tar_file,vol=80,pitch=100,pos=0)
        self.bgm_play("../../" + Z_MOD_FOLDER + "snd/#{tar_file}", vol,pitch, pos);
    end

    def self.bgsPlay(tar_file,vol=80,pitch=100,pos=0)
        self.bgs_play("../../" + Z_MOD_FOLDER + "snd/#{tar_file}", vol,pitch, pos);
    end

    # MISC

    def self.cursed(vol = 80, effect = 0)
        self.bgmPlay("417_cursed_main_theme", 80,0);
    end

    # MUSIC
    def self.tavern_warcraft(vol = 80, effect = 0)
        self.bgmPlay("The Witcher - Tavern at the End of World", 75,0);
    end

    def self.titleWitcherMusic()
        self.bgmPlay("The Witcher 3 - TheNightingale", 80, 0)
        #self.cursed();
    end

    def self.fistful_play(vol = 80, effect = 0)
        self.bgmPlay("The good, The bad and The ugly - Titoli", 140,effect);
    end

    def self.graveyard(vol = 80, effect = 0)
        self.bgmPlay("Graveyard", vol,effect);
    end

    def self.tavern_street(vol = 80, effect = 0)
        if $game_date.day?
            self.bgmPlay("Baldur's Gate - Safe in Beregost", vol,effect);
        elsif $game_date.night?
            self.bgmPlay("Baldur's Gate - The Friendly Arms Inn", vol,effect);
        end
    end

    def self.tavern(vol = 80, effect = 0)
        self.bgmPlay("Daggerfall - Town Square", vol,effect);
    end

end

#Inject BGM class
#NOTE:
#   It need for custom audio,
#   what placed in mod folder
=begin
def self.new_bgm_play(tar_file,vol=80,pitch=100,pos=0)
    $game_map.prev_bgm_name = RPG::BGM.last.name 
    $game_map.prev_bgm_volume = RPG::BGM.last.volume
    $game_map.prev_bgm_pitch = RPG::BGM.last.pitch
    $game_map.prev_bgm_pos = RPG::BGM.last.pos
    calculateVOL = (vol * ($data_BGMvol * 0.01)).to_i
    Audio.bgm_play("ModScripts/_Mods/" + Z_MOD_NAME + "/snd/#{tar_file}.ogg",calculateVOL,pitch,pos)  if calculateVOL > 0 && (tar_file != RPG::BGM.last.name || pitch != RPG::BGM.last.pitch)
    RPG::BGM.last.name = "snd/" + tar_file
    RPG::BGM.last.volume = vol
    RPG::BGM.last.pitch = pitch
    RPG::BGM.last.pos = pos
end

def self.new_bgs_play(tar_file,vol=80,pitch=100,pos=0)
    calculateVOL = (vol * ($data_SNDvol * 0.01)).to_i
    Audio.bgs_play("ModScripts/_Mods/" + Z_MOD_NAME + "/snd/#{tar_file}.ogg",calculateVOL,pitch,pos) if calculateVOL > 0 && (tar_file != RPG::BGS.last.name || pitch != RPG::BGS.last.pitch)
    RPG::BGS.last.name = "snd/" + tar_file
    RPG::BGS.last.volume = vol
    RPG::BGS.last.pitch = pitch
    RPG::BGS.last.pos = pos
end

def self.bgm_scene_on

    #Doc edit:
    local_tarName = RPG::BGM.last.name.split('/');

    tmpVol = RPG::BGM.last.volume
    tmpPit = RPG::BGM.last.pitch
    calculateVOL = ((tmpVol*0.8) * ($data_BGMvol * 0.01)).to_i
    calculatePIT = tmpPit#((tmpPit*0.9) * ($data_BGMvol * 0.01)).to_i
    if local_tarName[0] == "snd"
        Audio.bgm_play("ModScripts/_Mods/" + Z_MOD_NAME + "/#{RPG::BGM.last.name}.ogg",calculateVOL,calculatePIT,RPG::BGM.last.pos) if RPG::BGM.last.name != ""
        return;
    end
    Audio.bgm_play("Audio/BGM/#{RPG::BGM.last.name}.ogg",calculateVOL,calculatePIT,RPG::BGM.last.pos) if RPG::BGM.last.name != ""
end
def self.bgs_scene_on
    #Doc edit:
    local_tarName = RPG::BGS.last.name.split('/');

    tmpVol = RPG::BGS.last.volume
    tmpPit = RPG::BGS.last.pitch
    calculateVOL = ((tmpVol*0.7) * ($data_SNDvol * 0.01)).to_i
    calculatePIT = tmpPit#((tmpPit*1) * ($data_SNDvol * 0.01)).to_i
    if local_tarName[0] == "snd"
        Audio.bgs_play("ModScripts/_Mods/" + Z_MOD_NAME + "/#{RPG::BGS.last.name}.ogg",calculateVOL,calculatePIT,RPG::BGM.last.pos) if RPG::BGS.last.name != ""
        return;
    end
    Audio.bgs_play("Audio/BGS/#{RPG::BGS.last.name}.ogg",calculateVOL,calculatePIT,RPG::BGS.last.pos) if RPG::BGS.last.name != ""
end

def self.scene_off
    #Doc edit:
    local_tarName1 = RPG::BGS.last.name.split('/');
    local_tarName2 = RPG::BGM.last.name.split('/');

    tmpVol2 = RPG::BGM.last.volume
    tmpPit2 = RPG::BGM.last.pitch
    calculateVOL2 = (tmpVol2 * ($data_BGMvol * 0.01)).to_i
    calculatePIT2 = tmpPit2#((tmpPit*1) * ($data_SNDvol * 0.01)).to_i
    tmpVol1 = RPG::BGS.last.volume
    tmpPit1 = RPG::BGS.last.pitch
    calculateVOL1 = (tmpVol1 * ($data_SNDvol * 0.01)).to_i
    calculatePIT1 = tmpPit1#((tmpPit*1) * ($data_SNDvol * 0.01)).to_i
    if local_tarName2[0] == "snd"
        Audio.bgm_play("ModScripts/_Mods/" + Z_MOD_NAME + "/#{RPG::BGM.last.name}.ogg",calculateVOL2,calculatePIT2,RPG::BGM.last.pos) if RPG::BGM.last.name != ""
    else
        Audio.bgm_play("Audio/BGM/#{RPG::BGM.last.name}.ogg",calculateVOL2,calculatePIT2,RPG::BGM.last.pos) if RPG::BGM.last.name != ""
    end
    tmpVol = RPG::BGS.last.volume
    calculateVOL = (tmpVol * ($data_SNDvol * 0.01)).to_i
    if local_tarName1[0] == "snd"
        Audio.bgs_play("ModScripts/_Mods/" + Z_MOD_NAME + "/#{RPG::BGS.last.name}.ogg",calculateVOL1,calculatePIT1,RPG::BGM.last.pos) if RPG::BGS.last.name != ""
    else
        Audio.bgs_play("Audio/BGS/#{RPG::BGS.last.name}.ogg",calculateVOL1,calculatePIT1,RPG::BGM.last.pos) if RPG::BGS.last.name != ""
    end
end

class RPG::BGM < RPG::AudioFile
    #  @@last = RPG::BGM.new
    def play(pos = 0)
        if @name.empty?
            Audio.bgm_stop
            @@last = RPG::BGM.new
        else
            #Doc edit:
            local_tarName = @name.split('/');

            if local_tarName[0] == "snd"
                Audio.bgm_play("ModScripts/_Mods/" + Z_MOD_NAME + "/" + @name, @volume, @pitch, pos)
            else
                Audio.bgm_play('Audio/BGM/' + @name, @volume, @pitch, pos)
            end
            @@last = self.clone
        end
    end

end
=end