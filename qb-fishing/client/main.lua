QBCore = exports['qb-core']:GetCoreObject()

-- ################################################################################
--                                       LOCAL
-- ################################################################################

cachedData = {}
local diem_cau_ca = nil
local khoang_cach = nil
local noi_cau = nil
local namecu = 0
local Blip = nil
local isFishing = false
local DataPed = {}

-- ################################################################################
--                                     FUNCTION
-- ################################################################################

function KiemTraMoiThu(noi_cau)
    QBCore.Functions.TriggerCallback('qb-fishing:callback:us8iT5789GIiMq-k5ghUF7o985ZY-OasfYvLfM3N2AQZKl', function(count)
        if IsPedSwimming(cachedData["ped"]) then
            return QBCore.Functions.Notify(Config.Locales["dang_duoi_nuoc"], "error")
        end 
        if IsPedInAnyVehicle(cachedData["ped"]) then
            return QBCore.Functions.Notify(Config.Locales["dang_trong_xe"], "error")
        end 
        if count ~= nil then
            if count == 0 then
                QBCore.Functions.Notify(Config.Locales["thieu_cong_cu"], "primary")
            else
                local waterValidated, castLocation = KiemTraViTriCau()

                if waterValidated then
                    local fishingRod = TaoCanCau(cachedData["ped"])

                    ChuanBiCau(fishingRod, castLocation, noi_cau)
                else
                    QBCore.Functions.Notify(Config.Locales["dung_qua_xa"], "primary")
                end
            end
        end
    end, Config.DungCuCauCa["rod"]["name"], Config.DungCuCauCa["bait"]["name"])
end

function ChuanBiCau(rodHandle, castLocation, noi_cau)
    if isFishing then 
		return 
	end
    isFishing = true

    local startedCasting = GetGameTimer()

    if not CheckMoiCau() then
        QBCore.Functions.Notify(Config.Locales["het_moi_cau"], 'error')

        isFishing = false
        for k, v in pairs(DataPed) do
            DeleteEntity(v)
        end
        return DeleteEntity(rodHandle)
    end

    while not IsControlJustPressed(0, 47) do
        Wait(3)
		local coords = GetEntityCoords(PlayerPedId())
		DrawText3D(coords, Config.Locales["cau_va_ngung_cau"])
		if IsControlJustPressed(0, 73) then
			QBCore.Functions.Notify(Config.Locales["ngung_cau"], "primary")
            isFishing = false
			for k, v in pairs(DataPed) do
				DeleteEntity(v)
            end
            return DeleteEntity(rodHandle)
		end
        if GetGameTimer() - startedCasting > 60000 then
            QBCore.Functions.Notify(Config.Locales["dung_qua_lau"], "primary")

            isFishing = false
			for k, v in pairs(DataPed) do
				DeleteEntity(v)
            end
            return DeleteEntity(rodHandle)
        end
    end

    PlayAnimation(cachedData["ped"], "mini@tennis", "forehand_ts_md_far", {
        ["flag"] = 48
    })

    while IsEntityPlayingAnim(cachedData["ped"], "mini@tennis", "forehand_ts_md_far", 3) do
        Wait(0)
    end

    PlayAnimation(cachedData["ped"], "amb@world_human_stand_fishing@idle_a", "idle_c", {
        ["flag"] = 11
    })

    local startedBaiting = GetGameTimer()
    local randomBait = math.random(Config.ThoiGianCanCau[1], Config.ThoiGianCanCau[2])

    QBCore.Functions.Notify(Config.Locales["doi_ca_can_cau"], "success", "10000")
    TriggerServerEvent('QBCore:Server:RemoveItem', "fishingbait", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["fishingbait"], "remove", 1)

    local interupted = false

    Wait(1000)

    while GetGameTimer() - startedBaiting < randomBait do
        Wait(5)

        if not IsEntityPlayingAnim(cachedData["ped"], "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
            interupted = true

            break
        end
    end

    RemoveLoadingPrompt()

    if interupted then
        ClearPedTasks(cachedData["ped"])

        isFishing = false
        ChuanBiCau(rodHandle, castLocation)
        return DeleteEntity(rodHandle)
    end
    
    local caughtFish = TiepTucCau()

    ClearPedTasks(cachedData["ped"])

    if caughtFish then
        TriggerServerEvent("qb-fishing:server:tsY2i3E-IYRCoNArb8oroYV-lt2qu7TsKVVLSYGYA", noi_cau)
        TriggerServerEvent('hud:server:RelieveStress', 1)
    else
        QBCore.Functions.Notify(Config.Locales["cau_hut"], "error")
    end
    
    isFishing = false
    ChuanBiCau(rodHandle, castLocation)
    return DeleteEntity(rodHandle)
end

function TiepTucCau()
	local correct = math.random(5, 9)
    local checktime = GetGameTimer()
    while true do
        Wait(3)
		local coords = GetEntityCoords(PlayerPedId())
		DrawText3D(coords, Config.Locales["giat_can"]:format(correct))

        if IsControlJustReleased(0, 165) then
			input = 5
			break
		end
		if IsControlJustReleased(0, 159) then
			input = 6
			break
		end
		if IsControlJustReleased(0, 161) then
			input = 7
			break
		end
		if IsControlJustReleased(0, 162) then
			input = 8
			break
		end
        if IsControlJustReleased(0, 163) then
			input = 9
			break
		end
        if GetGameTimer() - checktime > 7000 then
            input = nil
            break
        end
    end
	if input == correct then
		return true
	else
		return false
	end
end

function KiemTraViTriCau()
    local startedCheck = GetGameTimer()

    local ped = cachedData["ped"]
    local pedPos = GetEntityCoords(ped)

    local forwardVector = GetEntityForwardVector(ped)
    local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 10, pedPos["y"] + forwardVector["y"] * 10, pedPos["z"])

    local fishHash = `a_c_fish`

    WaitForModel(fishHash)

    local waterHeight = GetWaterHeight(forwardPos["x"], forwardPos["y"], forwardPos["z"])

    local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)
    
    SetEntityAlpha(fishHandle, 0, true)

    -- QBCore.Functions.Notify("Đang kiểm tra địa điểm câu cá...", "success", "3000")

    while GetGameTimer() - startedCheck < 3000 do
        Wait(0)
    end

    RemoveLoadingPrompt()

    local fishInWater = IsEntityInWater(fishHandle)

    DeleteEntity(fishHandle)

    SetModelAsNoLongerNeeded(fishHash)

    return fishInWater, fishInWater and vector3(forwardPos["x"], forwardPos["y"], waterHeight) or false
end

function TaoCanCau(ped)
    local pedPos = GetEntityCoords(ped)
    
    local fishingRodHash = `prop_fishing_rod_01`

    WaitForModel(fishingRodHash)

    local rodHandle = CreateObject(fishingRodHash, pedPos, true)

    AttachEntityToEntity(rodHandle, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(fishingRodHash)

    return rodHandle
end

function CuaHangBanCa()
    Wait(10000)
    WaitForModel(Config.ChoBanCa["ped"]["model"])

    local pedHandle = CreatePed(5, Config.ChoBanCa["ped"]["model"], Config.ChoBanCa["ped"]["position"], Config.ChoBanCa["ped"]["heading"], false)

    SetEntityInvincible(pedHandle, true)
    SetEntityAsMissionEntity(pedHandle, true, true)
    SetBlockingOfNonTemporaryEvents(pedHandle, true)

    cachedData["storeOwner"] = pedHandle

    SetModelAsNoLongerNeeded(Config.ChoBanCa["ped"]["model"])

    local storeBlip = AddBlipForCoord(Config.ChoBanCa["ped"]["position"])
	
    SetBlipSprite(storeBlip, Config.ChoBanCa["blip"]["sprite"])
    SetBlipScale(storeBlip, 0.8)
    SetBlipColour(storeBlip, Config.ChoBanCa["blip"]["color"])
    SetBlipAsShortRange(storeBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.ChoBanCa["name"])
    EndTextCommandSetBlipName(storeBlip)
end

function TaoBlipViTriCau()
	local randomLocation = math.random(1, #Config.KhuVucCauCa)
    while (randomLocation == namecu) do
        Wait(10)
        randomLocation = math.random(1, #Config.KhuVucCauCa)
    end
	local name = Config.KhuVucCauCa[randomLocation].name
	local label = Config.KhuVucCauCa[randomLocation].label
	local coords = Config.KhuVucCauCa[randomLocation].coords
	local radius = Config.KhuVucCauCa[randomLocation].radius

	diem_cau_ca = coords
	khoang_cach = radius
	noi_cau     = name

	Blip = AddBlipForCoord(coords)
	SetBlipSprite(Blip, Config.ViTriCau["blip"]["sprite"])
	SetBlipDisplay(Blip, 4)
	SetBlipScale(Blip, 0.8)
	SetBlipAsShortRange(Blip, true)
	SetBlipColour(Blip, Config.ViTriCau["blip"]["color"])
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(label)
	EndTextCommandSetBlipName(Blip)
end

function XoaBlipViTriCau()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
	end
end

function BanCa()
    QBCore.Functions.TriggerCallback('qb-fishing:callback:us8iT5789GIiMq-k5ghUF7o985ZY-OasfYvLfM3N2AQZKl', function(count)
        TaskTurnPedToFaceEntity(cachedData["storeOwner"], cachedData["ped"], 1000)
        TaskTurnPedToFaceEntity(cachedData["ped"], cachedData["storeOwner"], 1000)

        TriggerServerEvent("qb-fishing:server:Q0MT2n-cROirKuNzgKLrE95-Z5cEff", function(sold, fishesSold) end)
    end)
end

function PlayAnimation(ped, dict, anim, settings)
	if dict then
        CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

function FadeOut(duration)
    DoScreenFadeOut(duration)
    
    while not IsScreenFadedOut() do
        Wait(0)
    end
end

function FadeIn(duration)
    DoScreenFadeIn(500)

    while not IsScreenFadedIn() do
        Wait(0)
    end
end

function WaitForModel(model)
    if not IsModelValid(model) then
        return
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

function DrawBusySpinner(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

function CheckMoiCau()
    local rtval = false
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(amount)
        if amount then
            rtval = true
        end
    end, "fishingbait")
    Wait(1000)
    return rtval
end

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(13)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- ################################################################################
--                                     EVENTS
-- ################################################################################

RegisterNetEvent("qb-fishing:client:k0VVtxR2LBi9RJ8I2I-ZRbPZVqzx7FwtbZwa-ohVmX", function()
	KiemTraMoiThu() 
end)

RegisterNetEvent("qb-fishing:client:Si5AaizdjMvGX94-1kHAsiIKU8Z-vBgG1iQH9Hz3z6ihRmiC", function()
	local ped = cachedData["ped"]
	local pedCoords = GetEntityCoords(ped)

	if diem_cau_ca ~= nil and khoang_cach ~= nil then
		local distance = #(pedCoords - diem_cau_ca)

		if distance < khoang_cach then
			KiemTraMoiThu(noi_cau)
		else
			QBCore.Functions.Notify(Config.Locales["dung_ngoai_vung"], "error")
		end
	else
		QBCore.Functions.Notify(Config.Locales["chua_nhan_diem"], "error")
	end
end)

RegisterNetEvent("qb-fishing:client:E1cOdUDB4P5ZeTc3D-s4GSxG-iBfaNLBDYQw", function(Hash)
	WaitForModel(GetHashKey(Hash))
    local pos = GetEntityCoords(PlayerPedId())

    local ped = CreatePed(29, GetHashKey(Hash), pos.x, pos.y, pos.z, 90.0, true, false)
    SetEntityHealth(ped, 0)
	table.insert(DataPed, ped)
end)

-- ################################################################################
--                                   CreateThread
-- ################################################################################

CreateThread(function()
	CuaHangBanCa()
	while true do
		local sleepThread = 5000
		local ped = cachedData["ped"]
		if DoesEntityExist(cachedData["storeOwner"]) then
			local pedCoords = GetEntityCoords(ped)
			local dstCheck = #(pedCoords - GetEntityCoords(cachedData["storeOwner"]))
            if dstCheck < 10.0 then
                sleepThread = 3
                if dstCheck < 3.0 then
                    sleepThread = 3
                    local displayText = not IsEntityDead(cachedData["storeOwner"]) and Config.Locales["nhan_diem_cau"] or Config.Locales["nguoi_mua_bat_tinh"]
                    if IsControlJustPressed(0, 38) then
                        for k, v in pairs(DataPed) do
                            DeleteEntity(v)
                        end
                        XoaBlipViTriCau()
                        BanCa()
                    end
                    if IsControlJustPressed(0, 47) then
                        for k, v in pairs(DataPed) do
                            DeleteEntity(v)
                        end
                        XoaBlipViTriCau()
                        TaoBlipViTriCau()
                        QBCore.Functions.Notify(Config.Locales["da_them_diem"], "success", "3000")
                    end
                    DrawText3D(Config.ChoBanCa["ped"]["position"], displayText)
                end
            end
		end
		Wait(sleepThread)
	end
end)

CreateThread(function()
	while true do
		Wait(1500)

		local ped = PlayerPedId()

		if cachedData["ped"] ~= ped then
			cachedData["ped"] = ped
		end
	end
end)