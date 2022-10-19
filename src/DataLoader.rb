
#FileGetter.load_mod_EventLib("ModScripts/_Mods/" + Z_MOD_NAME + "/data/Map190.rvdata2")
module DataManager
	self.singleton_class.send(:alias_method, :threesrd_load_overmap_obj, :load_mod_database)
	def self.load_mod_database
        FileGetter.load_mod_EventLib("ModScripts/_Mods/" + Z_MOD_NAME + "/data/Map191.rvdata2");

        $data_items << $data_ItemName["ItemApple"].clone 							#clone a APPLE to last item array, 
		$data_items.last.name = "FuckerApple"										#change its name to "CustomApple"
		$data_items.last.id = $data_items.length-1									#create item ID to last array length
		$data_items.last.icon_index = Z_MOD_FOLDER + "tex/FuckerApple"											#change icon ID
		$data_items.last.load_lona_effect_from_json("medicine_HiPotionLV5.json")	#change effect json
		$data_items.last.price=8964													#change price
		$data_ItemName[$data_items.last.name] = $data_items.last					#write it to ItemName hash
    end
end