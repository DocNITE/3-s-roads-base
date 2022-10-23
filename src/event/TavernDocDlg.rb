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
=end

callMsg("DocDlg:Tavern/Menu#{rand(3)+1}", 0, 2, 0);
def doc_t_m_dialog

	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutTavern"), "ABOUT_TAVERN"]
	tmpQuestList << [getTextInfo("DocDlg:Dlg/AboutGuests"), "ABOUT_GUESTS"]
	tmpQuestList << [getTextInfo("DocDlg:Dlg/Barter")			,"BARTER"]
	tmpQuestList << [getTextInfo("DocDlg:Dlg/Exit")				,"EXIT"]
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("\\optB[#{cmd_text}]")
	
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

    case tmpPicked
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
		manual_trade(good,charStoreHashName,charStoreTP,charStoreExpireDate,noSell=false,noBuy=false)
		#msgbox "check"
    else

    end
end
doc_t_m_dialog

cam_center(0);
$game_temp.choice = -1