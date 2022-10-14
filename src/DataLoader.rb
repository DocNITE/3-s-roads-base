
#FileGetter.load_mod_EventLib("ModScripts/_Mods/" + Z_MOD_NAME + "/data/Map190.rvdata2")
module DataManager
	self.singleton_class.send(:alias_method, :threesrd_load_overmap_obj, :load_mod_database)
	def self.load_mod_database
        FileGetter.load_mod_EventLib("ModScripts/_Mods/" + Z_MOD_NAME + "/data/Map191.rvdata2");
    end
end