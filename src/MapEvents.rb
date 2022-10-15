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
    # d_roadmap // in tavern street
    when Z_D_TAVERN_STREET_ROADMAP
        import(Z_MOD_NAME, "src/event/TavernStreetRoadmap.rb")
    else
        
    end
end

# When player enter in Overmap
def EventOvermapEnter(arg)
    EvLib.sum("-point-FFCGraveyard",29,88);
    EvLib.sum("-point-FFCTavern", 35, 72);
end
addEvent("OnOvermapEnter", method(:EventOvermapEnter));