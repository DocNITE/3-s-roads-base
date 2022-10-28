# Диалог с Докнайтовичем, заведующим таверной
=begin
tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_Cancel"]				,"Cancel"]			
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_Talk"]					,"Talk"]			if !tmpLisaAbom
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_LisaAbom"]				,"LisaAbom"]		if tmpLisaAbom
		tmpQuestList << [$game_text["commonNPC:commonNpc/Barter"]										,"Barter"]			
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_PregnancyCheck"]		,"PregnancyCheck"]	
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_OrcResearch"]			,"OrcResearch"]		if tmpOrcResearch
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_FishtopiaIsle"]			,"FishtopiaIsle"]	if tmpFishtopiaIsle
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_SellBaby"]				,"SellBaby"]	if tmpHasBaby
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("TagMapNoerEliseGynecology:elise/day_talk",0,2,0)
		call_msg("\\optB[#{cmd_text}]")
		
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1

		getTextInfo

		"3S: BROTHERHOOD_FRACTION"

		when "Prostitution"
		get_character(0).summon_data[:SexTradeble] = false
		$game_temp.choice == 0
		call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
		call_msg("commonNPC:RandomNpc/choosed")
		$game_player.actor.sta -=1 #WhoreWorkCost
		temp_vs1=5+rand(10) #性交易難度
		call_msg("\\narr #{$game_player.actor.weak.round} VS #{temp_vs1.round}")
		if $game_player.actor.weak > temp_vs1
			$game_player.actor.mood +=10
			$game_player.actor.record_whore_job +=1
			$game_player.actor.record_lona_title = "WhoreJob/title_hooker" if $game_player.actor.record_whore_job % 10 == 0
			call_msg("commonNPC:RandomNpc/WhoreWork_win")
			prev_gold = $game_party.gold
			play_sex_service_menu(get_character(0),0.5,"rand")
			play_sex_service_items(get_character(0),["ItemCoin1","ItemCoin2","ItemCoin3"],prev_gold)
		else
			$game_player.actor.mood -=3
			call_msg("commonNPC:RandomNpc/WhoreWork_failed")
		end
	end
=end

callMsg("DocDlg:Tavern/Menu#{rand(3)+1}", 0, 2, 0);

def doc_about_guests
	tmpAboutDirk = $story_stats["3s_doc_a_dirk"] == 0;
	tmpAboutShiza = $story_stats["3s_doc_a_shiza"] == 0;
	tmpAboutVolod = $story_stats["3s_doc_a_volod"] == 0;
	tmpAboutTaffer = $story_stats["3s_doc_a_taffer"] == 0;

	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutVolodimer"), "ABOUT_VOLOD"]	 if tmpAboutVolod
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutTaffer"), "ABOUT_TAFFER"]	 if tmpAboutTaffer
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutShiza"), "ABOUT_SHIZA"]	 if tmpAboutShiza
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutDick"), "ABOUT_DIRK"]	 if tmpAboutDirk
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("\\optB[#{cmd_text}]")
	portrait_hide
	
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

    case tmpPicked
	when "ABOUT_VOLOD"
		callMsg("DocDlg:Tavern/AboutVolodimer");
		$story_stats["3s_doc_a_volod"] = 1
	when "ABOUT_TAFFER"
		callMsg("DocDlg:Tavern/AboutTaffer");
		$story_stats["3s_doc_a_taffer"] = 1
	when "ABOUT_SHIZA"
		callMsg("DocDlg:Tavern/AboutShiza");
		$story_stats["3s_doc_a_shiza"] = 1
	when "ABOUT_DIRK"
		callMsg("DocDlg:Tavern/AboutDick");
		$story_stats["3s_doc_a_dirk"] = 1
	else
	end

	if $story_stats["3s_doc_a_dirk"] == 1 && 
		$story_stats["3s_doc_a_volod"] == 1 && 
		$story_stats["3s_doc_a_taffer"] == 1 && 
		$story_stats["3s_doc_a_shiza"] == 1

		$story_stats["3s_doc_about_guests"] = 1;
		doc_t_m_dialog
	else
		msgbox "ddd"
		doc_about_guests
	end
end

def doc_t_m_dialog

	tmpAboutTavern = $story_stats["3s_doc_about_tavern"] == 0;
	tmpAboutGuests = $story_stats["3s_doc_about_guests"] == 0 && !tmpAboutTavern;
	tmpJoinBh = $story_stats["3S: BROTHERHOOD_FRACTION"] == NOVICE && !tmpAboutTavern && !tmpAboutGuests;

	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutTavern"), "ABOUT_TAVERN"]	 if tmpAboutTavern
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutGuests"), "ABOUT_GUESTS"]  if tmpAboutGuests
	tmpQuestList << [getTextInfo("DocDlg:Dlg/JoinBrotherhood"), "JOIN_BROTHERHOOD"]  if tmpJoinBh
	tmpQuestList << [getTextInfo("DocDlg:Dlg/Barter")			,"BARTER"]
	tmpQuestList << [getTextInfo("DocDlg:Dlg/Exit")				,"EXIT"]
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("\\optB[#{cmd_text}]")
	portrait_hide
	
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

    case tmpPicked
	when "ABOUT_TAVERN"
		callMsg("DocDlg:Tavern/AboutTavern");
		cam_center(0);
		$story_stats["3s_doc_about_tavern"] = 1;
		doc_t_m_dialog
	when "ABOUT_GUESTS"
		if $game_party.has_item?($data_ItemName["ItemBottledBeer"]) || 
			$game_party.has_item?($data_ItemName["ItemFruitWine"]) ||
			$game_party.has_item?($data_ItemName["ItemSopGood"])

			callMsg("DocDlg:Tavern/AboutGuests");
			cam_center(0);
			doc_about_guests
		else
			callMsg("DocDlg:Tavern/AboutGuestsNoBeer");
		end
		cam_center(0);
		doc_t_m_dialog
	when "JOIN_BROTHERHOOD"
		#TODO:
    when "BARTER"
        shopNerf = ([([$story_stats["WorldDifficulty"].round,100].min)-0,0].max*0.001) #put the varible u want nerf shop,  if none put 0. var1=max  var2=min.   max-min must with in 100 (ex:weak125, -25)
		charStoreTP = 400  #wildHobo 150+rand(800) hobo 300+rand(1000) #Normie 500+rand(2000) #NonTradeShop 1000+rand(2500) #innkeeper 1000+rand(2500) #storeMarket 3000+rand(6000)
		charStoreExpireDate = $game_date.dateAmt+1+rand(4+$story_stats["Setup_Hardcore"]) #if nil. delete after close.  if < date. delete after nap.
		charStoreHashName = "#{@map_id}_#{get_character(0).id}".to_sym  #can be register with character name like "COCONA"
		
		#data 0item 1:weapon 2:armor
		#original price? 0,0   custom price? nil,price
		good=[
			[0,33 ,nil	, 300, 12],	#ItemFruitWine
			[0,49 ,nil	, 100  ,12],	#ItemSopGood
            [0,57 ,nil	, 250  ,12],	#ItemBottledBeer
			[0,$data_ItemName["3S_ItemTavernKey"].id ,nil	, 100  ,4]	#So, tavern key
			]

		callMsg("DocDlg:Tavern/Barter")

		manual_trade(good,charStoreHashName,charStoreTP,charStoreExpireDate,noSell=false,noBuy=false)
		#msgbox "check"
    else
		callMsg("DocDlg:Tavern/Exit");
    end
end
doc_t_m_dialog

cam_center(0);
$game_temp.choice = -1