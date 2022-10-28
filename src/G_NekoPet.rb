ViewSDK::TEXTURE_PATH = "#{Z_MOD_FOLDER}tex/CAT_MINI_GAME/"

module G_NekoPet
    WINDOW_BACK = CTexture.new(Rect.new(0, 0, 400, 300), "hand", 1129)
    WINDOW_BACK.sprite.bitmap = Bitmap.new(1,1);
    ViewSDK::makeWindowBitmap(WINDOW_BACK.sprite);
    WINDOW_BACK.setPosition((640/2)-(WINDOW_BACK.size.x/2), (360/2)-(WINDOW_BACK.size.y/2))

    TEX_HAND = CTexture.new(Rect.new(0, 0, 130, 53), "hand", 1131)
    ELEM_HAND= CElement.new(CVector2.new(130, 53), 1130);
    ELEM_HAND.addChild(TEX_HAND);

    TEX_CAT = CTexture.new(Rect.new(0, 0, 143, 146), "cat_face", 1130)
    ZONE_DETECT = CTexture.new(Rect.new(0, 0, 70, 30), "cat_face", 1131)
    ZONE_DETECT.setPosition(35, 0)
    ZONE_DETECT.sprite.bitmap = Bitmap.new(1, 1);
    TEX_CAT.addChild(ZONE_DETECT);

    # ZONE_DETECT - use in detect touch

    DRAW_SCORE = CDraw.new(CVector2.new(300, 40), "100.0%")

    def self.init()
        ELEM_HAND.setPosition((Graphics.width/2) - (130/2), (Graphics.height/2) - 53)
        TEX_CAT.setPosition((Graphics.width/2) - (143/2), Graphics.height - 166)

        newFont = Font.new()
        newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont.bold = false
        newFont.size = 40
        newFont.outline = true
        newFont.color = Color.new(255, 255, 255, 255);

        DRAW_SCORE.font = newFont;
        DRAW_SCORE.alligment = 1;
        DRAW_SCORE.setPosition((Graphics.width/2) - (300/2), 20)
        DRAW_SCORE.setText("0");
        @inGame = false;
        @canRender = false
        @score = 0;
        @isOut = true;
        @isIn  = false;
        @pX = 0
        @pY = 0 
    end

    def self.disable()
        ELEM_HAND.setVisible(false);
        TEX_CAT.setVisible(false);
        DRAW_SCORE.setVisible(false);
        WINDOW_BACK.setVisible(false);
        @inGame = false;
        @canRender = false
        #@score = 0;
        @pX = 0
        @pY = 0 
    end

    def self.enable()
        ELEM_HAND.setVisible(true);
        TEX_CAT.setVisible(true);
        DRAW_SCORE.setVisible(true);
        WINDOW_BACK.setVisible(true);
        @inGame = true
        @canRender = false
        @score = 0;
        @pX = 0
        @pY = 0 
    end

    def self.g_neko_PressButton(arg)
        if arg[1] == ELEM_HAND
            @canRender = true
            @pX = Mouse.pos?[MX] - ELEM_HAND.sprite.x;
            @pY = Mouse.pos?[MY] - ELEM_HAND.sprite.y;
        end
    end
    
    def self.g_neko_RealeseButton(arg)
        if arg[1] == ELEM_HAND
            @canRender = false
        end
    end
    
    def self.g_neko_Render(arg)
        if @canRender == true
            mResX = Mouse.pos?[MX]-@pX;
            mResY = Mouse.pos?[MY]-@pY;
            mResX = Math.clamp(mResX, 0, Graphics.width-ELEM_HAND.size.x);
            mResY = Math.clamp(mResY, 0, Graphics.height-ELEM_HAND.size.y);

            ELEM_HAND.position = CVector2.new(mResX, mResY);

            if self.within(ZONE_DETECT.sprite.x, ZONE_DETECT.sprite.y) == true && 
                self.within(ZONE_DETECT.sprite.x+ZONE_DETECT.size.x, ZONE_DETECT.sprite.y) == true

                if @isIn == false
                    @score += 1;
                    DRAW_SCORE.text = "#{@score}";
                    SndLib.meow;
                    @isIn = true;
                end
            else
                @isIn = false;
            end
        end
    end

    def self.within(m_x, m_y)
        tmpX = TEX_HAND.sprite.x;
        tmpY = TEX_HAND.sprite.y;
        tmpW = TEX_HAND.size.x;
        tmpH = TEX_HAND.size.y;
        return false if m_x < tmpX or m_y < tmpY
		bound_x = tmpX + tmpW; bound_y = tmpY + tmpH
		return true if m_x < bound_x and m_y < bound_y
		return false
    end

    def self.getScore()
        return @score;
    end

    def self.wait_when_end
        Fiber.yield while @inGame == true
    end
end
G_NekoPet.init()
G_NekoPet.disable();


EventSDK.addEvent("onMousePressed", G_NekoPet.method(:g_neko_PressButton))
EventSDK.addEvent("onMouseRealese", G_NekoPet.method(:g_neko_RealeseButton))
EventSDK.addEvent("onRender",       G_NekoPet.method(:g_neko_Render))

# Ладно похуй, завтра допилю мини игру. 
# Надо бы крч морозить лону и выключать худ
# И гладить кота ебать