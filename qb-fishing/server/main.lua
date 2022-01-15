QBCore = exports['qb-core']:GetCoreObject()

-- ################################################################################
--                                     CALLBACK
-- ################################################################################

QBCore.Functions.CreateCallback('qb-fishing:callback:us8iT5789GIiMq-k5ghUF7o985ZY-OasfYvLfM3N2AQZKl', function(source, cb, itemName)
	local retval = false
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	
	cb(retval)
end)

-- ################################################################################
--                                     USE ITEM
-- ################################################################################

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

	TriggerClientEvent('qb-fishing:client:Si5AaizdjMvGX94-1kHAsiIKU8Z-vBgG1iQH9Hz3z6ihRmiC', source)
end)

-- ################################################################################
--                                     EVENT
-- ################################################################################

RegisterNetEvent('qb-fishing:server:tsY2i3E-IYRCoNArb8oroYV-lt2qu7TsKVVLSYGYA', function(noi_cau)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

	if itemFound then
		for i = 1, itemCount, 1 do
			local randomItem = Config.DungCuCauCa["type"]math.random(1, 2)
			local itemInfo = QBCore.Shared.Items[randomItem]
			if luck == 100 then
				randomItem = "humpbackmeat"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_humpback")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 99 and luck <= 100 then
				randomItem = "killerwhalemeat"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_killerwhale")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 98 and luck <= 99 then
				randomItem = "stingraymeat"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_stingray")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 97 and luck <= 98 then
				randomItem = "sharkhammermeat"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_sharkhammer")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 95 and luck <= 97 then
				randomItem = "sharktigermeat"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_sharktiger")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 93 and luck <= 95 then
				randomItem = "dolphinmeat"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_dolphin")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 90 and luck <= 93 then
				randomItem = "goldfish"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_fish")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 85 and luck <= 90 then
				randomItem = "redfish"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_fish")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 80 and luck <= 85 then
				randomItem = "bluefish"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_fish")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 70 and luck <= 80 then
				randomItem = "stripedbass"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_fish")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			elseif luck >= 0 and luck <= 70 then
				randomItem = "fish"
				itemInfo = QBCore.Shared.Items[randomItem]
				Player.Functions.AddItem(randomItem, 1)
				TriggerClientEvent('qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw', src, "a_c_fish")
				TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
			end
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("qb-fishing:server:Q0MT2n-cROirKuNzgKLrE95-Z5cEff", function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local price1, price2, price3, price4, price5, price6, price7, price8, price9, price10, price11 = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	local TotalPrice = 0
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "fish" then 
                    price1 = price1 + (Config.DungCuCauCa["fish"]["price"] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("fish", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "stripedbass" then 
                    price2 = price2 + (Config.DungCuCauCa["stripedbass"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("stripedbass", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "bluefish" then 
                    price3 = price3 + (Config.DungCuCauCa["bluefish"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("bluefish", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "redfish" then 
                    price4 = price4 + (Config.DungCuCauCa["redfish"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("redfish", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "goldfish" then 
                    price5 = price5 + (Config.DungCuCauCa["goldfish"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("goldfish", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "dolphinmeat" then 
                    price6 = price6 + (Config.DungCuCauCa["dolphinmeat"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("dolphinmeat", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "sharktigermeat" then 
                    price7 = price7 + (Config.DungCuCauCa["sharktigermeat"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("sharktigermeat", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "sharkhammermeat" then 
                    price8 = price8 + (Config.DungCuCauCa["sharkhammermeat"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("sharkhammermeat", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "killerwhalemeat" then 
                    price9 = price9 + (Config.DungCuCauCa["killerwhalemeat"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("killerwhalemeat", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "stingraymeat" then 
                    price10 = price10 + (Config.DungCuCauCa["stingraymeat"]["price"] * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("stingraymeat", Player.PlayerData.items[k].amount, k)
				elseif Player.PlayerData.items[k].name == "humpbackmeat" then 
                    price11 = price11 + (Config.DungCuCauCa["humpbackmeat"]["price"] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("humpbackmeat", Player.PlayerData.items[k].amount, k)
                end
				TotalPrice = price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10 + price11
				if TotalPrice > 0 then
					Player.Functions.AddMoney("cash", TotalPrice, "sold-fish")
					TriggerClientEvent('QBCore:Notify', src, "Bạn bán cá được $" .. TotalPrice)
				end
            end
        end
	end
end)