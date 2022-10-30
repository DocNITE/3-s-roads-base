#ELEM_HAND = CWindow.new(CVector2.new(200, 100), _title="ewsewe", false, true, 1137);
#C_WINDOW = CWindow.new(CVector2.new(400, 200), _title="ddd", false, true, 1136);
#ViewSDK.makeInfoBitmap(C_WINDOW.sprite);
#C_WINDOW.addChild(ELEM_HAND);

#ELEM_HAND = CElement.new(CVector2.new(32, 32), true, 1137);
#C_WINDOW = CWindow.new(CVector2.new(400, 300), _title="Yantzee:", false, true, 1136);
#ViewSDK.makeInfoBitmap(ELEM_HAND.sprite);
#C_WINDOW.addChild(ELEM_HAND);

GAME_WINDOW = CWindow.new(CVector2.new(400, 300), _title="Yantzee:", false, true, 1140);
GAME_INFO_WINDOW = CWindow.new(CVector2.new(140, 90), _title="Round Result:", false, true, 1141);
GAME_INFO_WINDOW.setPosition(
    GAME_WINDOW.size.x/2 - GAME_INFO_WINDOW.size.x/2, 
    GAME_WINDOW.size.y/2 - GAME_INFO_WINDOW.size.y/2
)
ViewSDK::makeInfoBitmap(GAME_INFO_WINDOW);
GAME_WINDOW.addChild(GAME_INFO_WINDOW);


#Game Yantzee
# So, i love this system, and love this game
# So, if you hate my code - man, fuck you
# i love my shity(govno)code
module G_Yantzee


end