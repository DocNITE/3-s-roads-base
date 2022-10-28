# Внимание. Теперь вместо 0 ставим всегда 1. 
# Т.К. рубби детектит пустые таблицы со значением 0

# CAUTION!! You don't need make dialog variables in there. 
# Just use $story_stats["bla_bla"] == 0, and in end first dialog set $story_stats["bla_bla"] = 1

#Fraction level
NOVICE = 1;
FRIEND = 2;
RANGER = 3;
KNIGHT = 4;
MASTER = 5;

Z_STORY_STATS = [
    #---------------------------------------------------------
    # * Save version
    #---------------------------------------------------------
    ["3S: VER_INFO", Z_MOD_VERSION],

    #---------------------------------------------------------
    # * Intro variables
    #---------------------------------------------------------
    ["3S: INTRO_1", NO],

    # Shiza dialog (old var.)
    ["3S: SHIZA_FIRST_MEETING",   NO],  

    #---------------------------------------------------------
    # * Main stats
    #---------------------------------------------------------
    ["3S: FIRST_ENTER_IN_TAVERN",   NO],    #old
    ["3S: FIRST_MEETING_IN_TAVERN",   NO],  #old

    ["3S: BROTHERHOOD_FRACTION", NOVICE],
    #---------------------------------------------------------
    # * Quests
    #---------------------------------------------------------
    # For a Fistful Coins
    ["3S: CONVOY_VISIBLE",   NO],
    ["3S: FFC_QUEST_STATE",   1]
];



