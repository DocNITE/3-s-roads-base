chcg_background_color(0,0,0,255,7)
screen.start_tone_change(Tone.new(0,0,0,255),7)
callMsg("Title:Intro/CH1_0");
 sleep(10);
 callMsg("Title:Intro/CH1_1");
 sleep(10);
 callMsg("Title:Intro/CH1_2");
 sleep(10);
 callMsg("Title:Intro/CH1_3");
 sleep(5);
 screen.start_tone_change(Tone.new(0,0,0,0),7)
 chcg_background_color(0,0,0,0,7)
 $bg.erase
 $story_stats["3S: INTRO_1"] = YES;