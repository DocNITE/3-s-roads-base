=begin
* Eccma417 is gay, he played RimWorld
* Ты должен был бороться со злом, а не играть в игру
* с сообществом поддерживающим LGBT и ниггеров.
*
* 32/10/2022
* Извините девочки, я просто в депрессии. 
* Мне завтра надо сайт дописать для колледжа, а трачу время
* на мод для хентай игры.
* Не берите мои слова всерьез, я просто хочу выразиться.
* Я хочу поплакать в подушку, но не могу, ведь без меня
* не будет закончена демо версия мода "У трех дорог" (on eng: 3's roads)
*
* Я не думаю, что разработчик будет переводить этот комментарий
* но если даже переведет - it's just trolling.
*
* Но факт есть факт - eccma417 не любит китайские флаги, так что с этих пор
* на загрузке будет китайский флаг. Скажу, мол, забыл убрать из релиза
*
* Не, ну типо why not? Вообще мне должно быть похуй и я не обижен.
* Но с одной стороны я очень сильно хочу потроллить разработчика.
* И эта ситуация мне напоминает двуликого из бетмена, в перемешку с джокером
*
* Я КЛОУН БЛЯТЬ!!!!
*
* И еще у меня не все с головой в порядке, раз я пишу ебаный
* "Покер на костях"
*
* Крч пацаны, неважно сколько времени пройдет. Если есть время, пишите в лс:
* Discord:  DocNight#8500
* VK:       https://vk.com/koldun_iz_noterdama
*
* И да, люди, что обсуждают "какой билд лучше" - пусть сосут жЕпу.
* Билд через солнцезащитные очки из дебаггера - лучше.
*
* THE END
=end

class G_Yantzee < CWindow
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader :window_throw;    # Throw result win
    attr_reader :window_result;   # Round result win
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_z = ViewSDK::DEFAULT_WINDOW_Z)
        super(CVector2.new(400, 300), "", false, true, _z)
        @window_throw = G_Yantzee_Throw.new(_z+1);
        @window_throw.setPosition(
            @size.x/2 - @window_throw.size.x/2, 
            @size.y/2 - @window_throw.size.y/2
        )
        #ViewSDK::makeInfoBitmap(GAME_INFO_WINDOW.sprite);

        addChild(@window_throw);
        #@window_result = G_Yantzee_Result.new(z+1);
        #@window_result.setPosition(
        #    @size.size.x/2 - @window_result.size.x/2, 
        #    @size.size.y/2 - @window_result.size.y/2
        #)
        #ViewSDK::makeInfoBitmap(GAME_INFO_WINDOW.sprite);

        #addChild(@window_result);
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
end

class G_Yantzee_Result < CWindow
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_z = ViewSDK::DEFAULT_WINDOW_Z)
        super(CVector2.new(180, 120), "Throw result:", false, true, _z)
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
        local_raiseText = CDraw.new(CVector2.new(120, 14), "100.0%", _z+1);
        local_raiseText.font = newFont;
        local_raiseText.text = "Raise you're rate:"
        local_raiseText.setPosition(4, 80);
        addChild(local_raiseText);

        @rate_0     = CButton.new(CVector2.new(54, 20), false, false, false, _z+1);
        ViewSDK::makeInfoBitmap(@rate_0.sprite);
        @rate_0.setPosition(6, 120-@rate_0.size.y-6)
        addChild(@rate_0);

        @rate_0_info = CDraw.new(CVector2.new(@rate_0.size.x, 12), "0", _z+2);
        @rate_0_info.font = newFont;
        @rate_0_info.alligment = 1;
        @rate_0_info.text = "0"
        @rate_0_info.color = Color.new(255, 255, 255)
        @rate_0_info.setPosition(0, @rate_0.size.y/2 - @rate_0_info.size.y/2);
        @rate_0.addChild(@rate_0_info)


    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
end

class G_Yantzee_Throw < CWindow
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_z = ViewSDK::DEFAULT_WINDOW_Z)
        super(CVector2.new(180, 120), "Throw result:", false, true, _z)
        resultFont = Font.new()
        resultFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        resultFont.bold = false
        resultFont.size = 16
        resultFont.outline = false
        resultFont.color = Color.new(255, 255, 255, 255);

        newFont = Font.new()
        newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont.bold = false
        newFont.size = 14
        newFont.outline = false
        newFont.color = Color.new(255, 255, 255, 255);
        @iHateTaiwan = CDraw.new(CVector2.new(120, 16), "Fuck eccma417 and he polit position", _z+1);
        @iHateTaiwan.font = resultFont;
        @iHateTaiwan.text = "NaN | Error msg"
        @iHateTaiwan.setPosition(4, 80);
        addChild(@iHateTaiwan);

        @FuckEccma417     = CButton.new(CVector2.new(54, 20), false, false, false, _z+1);
        ViewSDK::makeInfoBitmap(@FuckEccma417.sprite);
        @FuckEccma417.setPosition(6, 120-@FuckEccma417.size.y-6)
        addChild(@FuckEccma417);
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
end

#GAME_WINDOW = CWindow.new(CVector2.new(400, 300), _title="Yantzee:", false, true, 1140);
TEST_TESTY = G_Yantzee.new(1140);

#GAME_INFO_WINDOW = CWindow.new(CVector2.new(180, 120), _title="Round Result:", false, true, 1141);


#Game Yantzee
# So, i love this system, and love this game
# So, if you hate my code - man, fuck you
# i love my shity(govno)code
module Game_Yantzee


end