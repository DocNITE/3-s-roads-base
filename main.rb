#==============================================================================
# ** Main entry file
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file connect all scripts, what exist in '/src' folder.                            
#==============================================================================
#==============================================================================
# ** Да кста, кто возьмет наработки или будет делать по моему шаблону -
# ** тот мудак.
# **
# ** Разумеется без разрешения самого автора на использование материалов
# ** данной интелектуальной собственности производимой в РФ на территории СНГ!
# **
# ** Если тебе нужна помощь в написании мода, просто напиши мне.
# ** И да, мои контакты:
# ** Discord:  DocNight#8500
# ** VK:       https://vk.com/koldun_iz_noterdama
# **
# ** Да кста, я поддерживаю Китай и считаю Тайвань частью Китая.
# ** ...
# ** Извините пожалуйста, Рамзан Eccma417, я пошутил, правда.
# ** Только не баньте в дискорде, прошу!
#==============================================================================
 
#Define
Z_MOD_NAME          = "3-s-roads-base";
Z_MOD_FOLDER        = "ModScripts/_Mods/" + Z_MOD_NAME + "/";

Z_MOD_VERSION       = "0.1.0";

# include script file
def import(path, file)
    load_script("ModScripts/_Mods/" + path + "/" + file);
end

#Constants
import(Z_MOD_NAME, "src/Constant.rb"        );
import(Z_MOD_NAME, "src/StoryStats.rb"      );

#load dev.bak. edit's for 0.7.3.0 version
load_from_list(getFileList("#{Z_MOD_FOLDER}src/dev_bak_support/*.rb"))

#main SDK
#import(Z_MOD_NAME, "src/CEventMap.rb"       );
import(Z_MOD_NAME, "src/EventListener.rb"   );
import(Z_MOD_NAME, "src/Utils.rb"           );

#Init
import(Z_MOD_NAME, "src/DataLoader.rb"      );
import(Z_MOD_NAME, "src/MapEvents.rb"       );
import(Z_MOD_NAME, "src/Achievement.rb"  );

#main hook files
import(Z_MOD_NAME, "src/ISndLib.rb"         );
import(Z_MOD_NAME, "src/IGameMap.rb"        );
import(Z_MOD_NAME, "src/IGameEvent.rb"      );
import(Z_MOD_NAME, "src/IGamePlayer.rb"     );
import(Z_MOD_NAME, "src/IItemConfigs.rb"    );
import(Z_MOD_NAME, "src/IDataManager.rb"    );
import(Z_MOD_NAME, "src/ISceneMapTitle.rb"  );

#main
import(Z_MOD_NAME, "src/G_NekoPet.rb"  );
#import(Z_MOD_NAME, "src/G_Yantzee.rb"  );
#import(Z_MOD_NAME, "src/CEnemyBar.rb"  );