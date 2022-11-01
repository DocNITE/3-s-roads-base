#==============================================================================
# ** 
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject module for main module in Data files                             
#==============================================================================

#Enumeration
module ItemType
	ITEM	= 0;
	WEAPON  = 1;
	ARMOR 	= 2;
end

#Inject
module DataManager
	self.singleton_class.send(:alias_method, :threesrd_load_overmap_obj, :load_mod_database)
	def self.load_mod_database
		#----------------------------------------------------------
		# * Load map/event objects
		#----------------------------------------------------------
        FileGetter.load_mod_EventLib("ModScripts/_Mods/" + Z_MOD_NAME + "/data/Map191.rvdata2");

		#----------------------------------------------------------
		# * ITEMS:
		#----------------------------------------------------------

		# * Tavern 3's roads room key
		#    code	:	3S_ItemTavernKey		
		addCustomItem(
			#Type
			ItemType::ITEM, 
			#Parent item
			$data_ItemName["ItemNoerTavernNapKey"], 
			#Info
			[
				#Name
				getTextInfo("Items:3S_ItemTavernKey/Name"),
				#Ev_Name
				"3S_ItemTavernKey",
				#Description
				getTextInfo("Items:3S_ItemTavernKey/Description"),
				#Icon
				nil,
				#Effect
				nil,
				#Price
				300
			]
		)	

		# * Tavern 3's roads Tuchmi room
		#    code	:	3S_ItemTavernKeyForever		
		addCustomItem(
			#Type
			ItemType::ITEM, 
			#Parent item
			$data_ItemName["ItemPirateBaneInnNapKey"], 
			#Info
			[
				#Name
				getTextInfo("Items:3S_ItemTavernKeyForever/Name"),
				#Ev_Name
				"3S_ItemTavernKeyForever",
				#Description
				getTextInfo("Items:3S_ItemTavernKeyForever/Description"),
				#Icon
				nil,
				#Effect
				nil,
				#Price
				10000
			]
		)
		
		# * Taicon / For grabling games coin
		#    code	:	3S_ItemTaicon		
		addCustomItem(
			#Type
			ItemType::ITEM, 
			#Parent item
			$data_ItemName["ItemCoin1"], 
			#Info
			[
				#Name
				getTextInfo("Items:3S_ItemTaicon/Name"),
				#Ev_Name
				"3S_ItemTaicon",
				#Description
				getTextInfo("Items:3S_ItemTaicon/Description"),
				#Icon
				"#{Z_MOD_FOLDER}tex/item_taicon",
				#Effect
				nil,
				#Price
				0
			]
		)	
		
		# * Pre-Graveyard Treasure Map
		#    code	:	3S_ItemGraveyardMapPRE		
		addCustomItem(
			#Type
			ItemType::ITEM, 
			#Parent item
			$data_ItemName["ItemNoerTavernNapKey"], 
			#Info
			[
				#Name
				getTextInfo("Items:3S_ItemGraveyardMapPRE/Name"),
				#Ev_Name
				"3S_ItemGraveyardMapPRE",
				#Description
				getTextInfo("Items:3S_ItemGraveyardMapPRE/Description"),
				#Icon
				"#{Z_MOD_FOLDER}tex/item_map",
				#Effect
				nil,
				#Price
				40000
			]
		)	

		# * Nuka-Battery
		#    code	:	3S_ItemNukaBattery		
		addCustomItem(
			#Type
			ItemType::ITEM, 
			#Parent item
			$data_ItemName["ItemNoerTavernNapKey"], 
			#Info
			[
				#Name
				getTextInfo("Items:3S_ItemNukaBattery/Name"),
				#Ev_Name
				"3S_ItemNukaBattery",
				#Description
				getTextInfo("Items:3S_ItemNukaBattery/Description"),
				#Icon
				"#{Z_MOD_FOLDER}tex/item_nuka_battery",
				#Effect
				nil,
				#Price
				18000
			]
		)	
    end
end

#$game_party.gain_item($data_ItemName["3S_ItemGraveyardMapPRE"], 1);
#----------------------------------------------------------
# * Add new item in game
#----------------------------------------------------------
def addCustomItem(i_type, i_parent, i_info)
	if i_type == ItemType::ITEM
		if i_parent != nil
			$data_items << i_parent.clone 	
		else
			return;
		end
		$data_items.last.name = i_info[0]			
		$data_items.last.item_name = i_info[1];				
		$data_items.last.description = i_info[2];					
		$data_items.last.id = $data_items.length-1						
		$data_items.last.icon_index = i_info[3] if i_info[3] != nil			
		$data_items.last.load_lona_effect_from_json(i_info[4]) if i_info[4] != nil	
		$data_items.last.price=i_info[5]													
		$data_ItemName[$data_items.last.item_name] = $data_items.last		
	end
end