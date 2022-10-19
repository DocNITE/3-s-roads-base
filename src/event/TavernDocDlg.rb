# Диалог с Докнайтовичем, заведующим таверной

def doc_t_m_dialog
    callMsg("Tevern_3_roads_main:Tavern/Menu#{rand(3)+1}");

    case $game_temp.choice
    when 0
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
    else

    end
end
doc_t_m_dialog

cam_center(0);
$game_temp.choice = -1;