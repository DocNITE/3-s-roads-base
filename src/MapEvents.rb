#==============================================================================
# ** Overmap load maps
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain object                  
#==============================================================================

# When player choice location on overmap
def OnMapChoice(mID)
    case mID
    # ev_tavern
    when Z_TAVERN_STREET_EV
        import(Z_MOD_NAME, "src/event/map/Overmap3roads.rb")
    when Z_TAVERN_GRAVEYARD_EV
        import(Z_MOD_NAME, "src/event/map/OvermapGraveyard.rb")
    else
        
    end
end

# When player start dialog
def OnDialogStart(mID)
    case mID
    # TAVERN STREET
    # d_roadmap // in tavern street
    when Z_D_TAVERN_STREET_ROADMAP
        import(Z_MOD_NAME, "src/event/TavernStreetRoadmap.rb")
    else
        
    end
end

# When player enter in Overmap
def EventOvermapEnter()
    EvLib.sum("-point-FFCGraveyard",29,88);
    EvLib.sum("-point-FFCTavern", 35, 72);
end
#addEvent("OnOvermapEnter", method(:EventOvermapEnter));

# When player enter in Overmap and play intro
=begin
def EventIntro()
    if $story_stats["3S: INTRO_1"] == NO
        callMsg("Title:Intro/CH1_0");
        sleep(10);
        callMsg("Title:Intro/CH1_1");
        sleep(10);
        callMsg("Title:Intro/CH1_2");
        sleep(10);
        callMsg("Title:Intro/CH1_3");
        sleep(5);
        $cg.erase

        $story_stats["3S: INTRO_1"] = YES;
    end
end
=end
#addEvent("OnOvermapEnter", method(:EventIntro));