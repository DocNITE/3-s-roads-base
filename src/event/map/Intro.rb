#
if $story_stats["3S: iintro_1"] == 0
    chcg_background_color(0,0,0,255,7)
    screen.start_tone_change(Tone.new(0,0,0,255),7)
    callMsg("Title:Intro/CH_1");
    #wait(1000)
    #callMsg("Title:Intro/CH1_1");
    #wait(1000)
    #callMsg("Title:Intro/CH1_2");
    #wait(1000)
    #callMsg("Title:Intro/CH1_3");
    #wait(1000)
    screen.start_tone_change(Tone.new(0,0,0,0),7)
    chcg_background_color(0,0,0,0,7)
    $bg.erase
    $story_stats["3S: iintro_1"] = 1
end

#@tarGotoX1,@tarGotoY1#$game_map.get_storypoint("midPr0")
#self.moveto(@tarGotoX1,@tarGotoY1)