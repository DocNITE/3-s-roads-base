module ItemConfigs
	#從指定的格式去取得資料 
	#格式 KEY=VALUE (CRLF)
	AFFECT_INCREASE = "+"
	AFFECT_DECREASE = "-"
	AFFECT_MULTIPLY = "*"
	AFFECT_DIVISION = "/"
	
	attr_accessor       :description
	attr_accessor       :name
	attr_accessor       :item_name
	attr_accessor       :configured
	attr_accessor       :type_tag
	attr_accessor       :type
	attr_accessor       :sell_price
	attr_accessor       :addData
	#Struct.new("ItemEffect",:attr,:attr_type,:type,:adjust,:stats_key,:stats_value,:stats_filter)
	#Struct.new("SkillEffect",:attr,:attr_type,:type,:adjust,:stats_key,:stats_value,:stats_filter)
	
	#通用進入點，任何要取得的參數為nil時都呼叫此方法
	def load_additional_data
		@addData=Note.get_data(self.note)
		@configured=configured_item?(addData)
		load_misc_settings(addData)
		load_custom_texts(get_category,addData["flag"]) unless addData["flag"].nil?
		return unless @configured
		load_lona_effect_from_json(addData["eff_cfg"]) if !addData["eff_cfg"].nil?
	end
	
	def get_sell_price
		case type_tag
			when "Money"
				temp_wisdom_fix = $game_player.actor.wisdom*0.001
				temp_final_price = (@price * [0.9+temp_wisdom_fix,0.95].min).round
				temp_final_price
			else
				temp_wisdom_fix = $game_player.actor.wisdom*0.005
				temp_final_price = (@price * [0.5+temp_wisdom_fix,0.95].min).round
				temp_final_price
		end
	temp_final_price
	end
	
	def load_misc_settings(addData)
		@type_tag=addData["tag"]
		@type=addData["type"]
	end
	
	def load_custom_texts(category,flag)		
		@item_name=@name
		return if category.nil? || flag.nil? || flag.eql?("")
		@description=$game_text["#{category}:#{flag}/description"].to_s
		item_name=$game_text["#{category}:#{flag}/item_name"].to_s  
		@name=item_name unless item_name.nil?
	end
		
	def load_lona_effect_from_json(filename)
		if FileGetter::COMPRESSED
			effectData= $data_itemconfigs["#{base_folder}/#{filename}"] 
			effectData={} if effectData.nil?
		else
			effectData=JSON.decode(open("#{base_folder}/#{filename}").read)
			$data_itemconfigs["#{base_folder}/#{filename}"]=effectData
		end
		load_weight(effectData)
		load_multipliers(effectData)
		load_lona_effect_from_hash(effectData)
	end
	
	def load_lona_effect_from_hash(data)
		p "load_lona_effect_from_hash - id=#{@id},self.class=#{self.class}---0"
		@lona_effect=Array.new
		return if data["attribute_change"].nil?
		data["attribute_change"].each{
			|effectUnit|
			next if acceptable_types.index(effectUnit["attribute_type"]).nil?
			attr_type=ActorStat::CURRENT_STAT
			case effectUnit["attribute_type"]
				when "max";		attr_type=ActorStat::MAX_STAT
				when "Tmax";    attr_type=ActorStat::MAX_TRUE
				when "Tmin";    attr_type=ActorStat::MIN_TRUE
				when "min";     attr_type=ActorStat::MIN_STAT
				when "current"; attr_type=ActorStat::CURRENT_STAT
			end
			@lona_effect.push(ItemEffect.new(effectUnit["attribute_name"],attr_type,effectUnit["adjustor"],effectUnit["adjustment"].to_f,effectUnit["stats_key"],effectUnit["stats_value"],effectUnit["stats_filter"]))
		}
		
	end
	def get_type_and_id
		return [0,self.id] if self.class == RPG::Item
		return [1,self.id] if self.class == RPG::Armor
		return [2,self.id] if self.class == RPG::Weapon
	end
	def configured_item?(addData)
		return false if addData.nil? || addData=={}
		return false if addData["flag"].nil? || (addData["tag"].nil? && addData["type"].nil? )
		return true
	end
	
	def load_multipliers(addData)
		if addData.nil?
			@dmg_multiplier		= 1
			@throw_multiplier	= 1
			return 
		end
		@dmg_multiplier		=	addData["dmg_multiplier"]
		@throw_multiplier	=	addData["throw_multiplier"]
		@dmg_multiplier		=	(@dmg_multiplier.nil? || @dmg_multiplier.eql?(""))		?	1 : @dmg_multiplier.to_f
		@throw_multiplier	=	(@throw_multiplier.nil? || @throw_multiplier.eql?(""))	?	1 : @throw_multiplier.to_f
	end
	
	
	#=================================================================================================
	#外部連接器
	#=================================================================================================	
	
	def lona_effect
		addData=Note.get_data(self.note)
		@configured=configured_item?(addData) if @configured.nil?
		return [] if !@configured
		load_additional_data if @lona_effect.nil?
		@lona_effect
	end
	
	def weight
		return 0.0 if !@configured
		load_additional_data if @weight.nil?
		@weight
	end
	
	#設置陷阱時使用的Multiplier
	def dmg_multiplier
		return 1 if !@configured
		@dmg_multiplier
	end
	
	#投擲時使用的Multiplier
	def throw_multiplier
		return 1 if !@configured
		@throw_multiplier
	end
	

	#=================================================================================================
	#內部複寫用
	#=================================================================================================
	#取得文字檔所在的資料夾
	def get_text_folder
		raise "方法 ItemConfigs::get_text_folder 未被覆寫，無法運作。"
	end
	
	#取得文字檔的類型(檔名)
	def get_category
		raise "方法 ItemConfigs::get_category 未被覆寫，無法運作。"
	end
	
	#取得這個物件的base_folder
	def base_folder
		raise "方法 ItemConfigs::base_folder 未被覆寫，無法運作。"
	end

	#從物件json中讀取weight屬性，以及multipliers
	def load_weight(dataSrc)
		return @weight=0.0 if dataSrc.nil? 
		@weight=dataSrc["weight"].to_f		
	end	
	
	#這種物件接受變更哪些類型的屬性
	def acceptable_types
		["max","min","Tmax","Tmin","current"]
	end
	
	def not_acceptable_type_msg(result,type)
		if result.nil?
			return "#{get_category} ： #{@name} unknown ATTRIBUTE TYPE : #{type}"
		else
			return "#{get_category} ： #{@name} CAN NOT CHANGE ATTRIBUTE  TYPE: #{type}"
		end		
	end
	
	
	#Struct.new("ItemEffect",:attr,:attr_type,:type,:adjust,:stats_key,:stats_value,:stats_filter)
	#Struct.new("SkillEffect",:attr,:attr_type,:type,:adjust,:stats_key,:stats_value,:stats_filter)
	class ItemEffect
		attr_reader :attr
		attr_reader :attr_type
		attr_reader :type
		attr_reader :adjust
		attr_reader :stats_key
		attr_reader :stats_value
		attr_reader :stats_filter
		def initialize(attr,attr_type,type,adjust,stats_key,stats_value,stats_filter)
			@attr         =	attr
			@attr_type    =	attr_type
			@type         =	type
			@adjust       =	adjust
			@stats_key    =	stats_key
			@stats_value  =	stats_value
			@stats_filter =	stats_filter
		end
	end
	
	class SkillEffect < ItemEffect
	end

end