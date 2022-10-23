#==============================================================================
# ** Main entry file
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file connect all scripts, what exist in '/src' folder.                            
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
#import(Z_MOD_NAME, "src/CEnemyBar.rb"  );