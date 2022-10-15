#==============================================================================
# ** Inject in DataManager. We just put our own story stats
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#inject

module DataManager

  #--------------------------------------------------------------------------
  # * Execute Load (No Exception Processing)
  #--------------------------------------------------------------------------
	def self.load_game_without_rescue(index)
			File.open(make_filename(index), "rb") do |file|
			header = DataManager.load_header(index)
			return false if header[:doom_mode]
			Marshal.load(file)
			extract_save_contents(Marshal.load(file))
			import(Z_MOD_NAME, "src/event/LoadStoryStats.rb");
			#reload_map_if_updated
			@last_savefile_index = index
			$hudForceHide = false
			$balloonForceHide = false
		#$game_portraits.fetch_lona_portrait
		end
		return true
	end
	
	def self.load_doom_without_rescue
			File.open(make_filenameDoom, "rb") do |file|
			Marshal.load(file)
			extract_save_contents(Marshal.load(file))
			import(Z_MOD_NAME, "src/event/LoadStoryStats.rb");
			$hudForceHide = false
			$balloonForceHide = false
		end
		return true
	end
	
	def self.load_custom_without_rescue(tmpName)
		tmpTar = sprintf("#{tmpName}.rvdata2")
		File.open(tmpTar, "rb") do |file|
			Marshal.load(file)
			extract_save_contents(Marshal.load(file))
			import(Z_MOD_NAME, "src/event/LoadStoryStats.rb");
			$hudForceHide = false
			$balloonForceHide = false
		end
		return true
	end

	def self.customLoadName
		@customLoadName
	end
	
	def self.customLoadNameSet(tmpVal)
		@customLoadName = tmpVal
	end
end