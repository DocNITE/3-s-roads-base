#ELEM_HAND = CWindow.new(CVector2.new(200, 100), _title="ewsewe", false, true, 1137);
#C_WINDOW = CWindow.new(CVector2.new(400, 200), _title="ddd", false, true, 1136);
#ViewSDK.makeInfoBitmap(C_WINDOW.sprite);
#C_WINDOW.addChild(ELEM_HAND);

#ELEM_HAND = CElement.new(CVector2.new(32, 32), true, 1137);
#C_WINDOW = CWindow.new(CVector2.new(400, 300), _title="Yantzee:", false, true, 1136);
#ViewSDK.makeInfoBitmap(ELEM_HAND.sprite);
#C_WINDOW.addChild(ELEM_HAND);

GAME_WINDOW = CWindow.new(CVector2.new(400, 300), _title="Yantzee:", false, true, 1140);

GAME_INFO_WINDOW = CWindow.new(CVector2.new(180, 120), _title="Round Result:", false, true, 1141);

ppFont = Font.new()
ppFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
ppFont.bold = false
ppFont.size = 12
ppFont.outline = false
ppFont.color = Color.new(255, 255, 255, 255);

newFont = Font.new()
newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
newFont.bold = false
newFont.size = 14
newFont.outline = false
newFont.color = Color.new(255, 255, 255, 255);
GAME_INFO_ADD_BID = CDraw.new(CVector2.new(120, 14), "100.0%", 1142);
GAME_INFO_ADD_BID.font = newFont;
GAME_INFO_ADD_BID.text = "Raise you're rate:"
GAME_INFO_ADD_BID.setPosition(4, 70);
GAME_INFO_WINDOW.addChild(GAME_INFO_ADD_BID);

GAME_ADD_BP     = CButton.new(CVector2.new(54, 20), false, false, false, 1142);
ViewSDK::makeInfoBitmap(GAME_ADD_BP.sprite);
GAME_ADD_BP.setPosition(6, 120-GAME_ADD_BP.size.y-6)
GAME_INFO_WINDOW.addChild(GAME_ADD_BP);

GAME_INFO_BP = CDraw.new(CVector2.new(GAME_ADD_BP.size.x, 12), "0", 1143);
GAME_INFO_BP.font = newFont;
GAME_INFO_BP.alligment = 1;
GAME_INFO_BP.text = "0"
GAME_INFO_BP.color = Color.new(255, 255, 255)
GAME_INFO_BP.setPosition(0, GAME_ADD_BP.size.y/2 - GAME_INFO_BP.size.y/2);
GAME_ADD_BP.addChild(GAME_INFO_BP)

GAME_ADD_BPP    = CButton.new(CVector2.new(GAME_ADD_BP.size.x, GAME_ADD_BP.size.y), false, false, false, 1142);
ViewSDK::makeInfoBitmap(GAME_ADD_BPP.sprite);
GAME_ADD_BPP.setPosition(6+GAME_ADD_BP.size.x+3, 120-GAME_ADD_BP.size.y-6)
GAME_INFO_WINDOW.addChild(GAME_ADD_BPP);
bpp = CDraw.new(CVector2.new(120, 12), "+", 1144);
bpp.font = ppFont;
bpp.text = "+"
bpp.color = Color.new(0, 255, 0)
bpp.setPosition(2, 0);
GAME_ADD_BPP.addChild(bpp);

GAME_INFO_BPP = CDraw.new(CVector2.new(GAME_ADD_BP.size.x, 12), "30", 1143);
GAME_INFO_BPP.font = newFont;
GAME_INFO_BPP.alligment = 1;
GAME_INFO_BPP.text = "30"
GAME_INFO_BPP.color = Color.new(255, 255, 255)
GAME_INFO_BPP.setPosition(0, GAME_ADD_BP.size.y/2 - GAME_INFO_BP.size.y/2);
GAME_ADD_BPP.addChild(GAME_INFO_BPP)

GAME_ADD_BPPP   = CButton.new(CVector2.new(GAME_ADD_BP.size.x, GAME_ADD_BP.size.y), false, false, false, 1142);
ViewSDK::makeInfoBitmap(GAME_ADD_BPPP.sprite);
GAME_ADD_BPPP.setPosition(6+GAME_ADD_BP.size.x+3+GAME_ADD_BP.size.x+3, 120-GAME_ADD_BP.size.y-6)
GAME_INFO_WINDOW.addChild(GAME_ADD_BPPP);
bpp = CDraw.new(CVector2.new(120, 12), "+", 1144);
bpp.font = ppFont;
bpp.text = "++"
bpp.color = Color.new(255, 0, 0)
bpp.setPosition(2, 0);
GAME_ADD_BPPP.addChild(bpp);

GAME_INFO_BPPP = CDraw.new(CVector2.new(GAME_ADD_BP.size.x, 12), "30", 1143);
GAME_INFO_BPPP.font = newFont;
GAME_INFO_BPPP.alligment = 1;
GAME_INFO_BPPP.text = "60"
GAME_INFO_BPPP.color = Color.new(255, 255, 255)
GAME_INFO_BPPP.setPosition(0, GAME_ADD_BP.size.y/2 - GAME_INFO_BP.size.y/2);
GAME_ADD_BPPP.addChild(GAME_INFO_BPPP)

GAME_INFO_WINDOW.setPosition(
    GAME_WINDOW.size.x/2 - GAME_INFO_WINDOW.size.x/2, 
    GAME_WINDOW.size.y/2 - GAME_INFO_WINDOW.size.y/2
)
#ViewSDK::makeInfoBitmap(GAME_INFO_WINDOW.sprite);

GAME_WINDOW.addChild(GAME_INFO_WINDOW);


#Game Yantzee
# So, i love this system, and love this game
# So, if you hate my code - man, fuck you
# i love my shity(govno)code
module G_Yantzee


end