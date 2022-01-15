QBCore = exports['qb-core']:GetCoreObject()

-- ################################################################################
--                                       LOCAL
-- ################################################################################

local PlayerJob = {}

-- ################################################################################
--                                     FUNCTION
-- ################################################################################

local function DrawText3D(coords, text)
    local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 10)
end

function Epnuoccam()
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.9, -0.98))

    prop = CreateObject(GetHashKey('beerrow_local'), x, y, z,  true,  true, true)
    prop2 = CreateObject(GetHashKey('apa_mp_h_acc_fruitbowl_01'), x, y, z,  true,  true, true)
    SetEntityHeading(prop, GetEntityHeading(ped))
    SetEntityHeading(prop2, GetEntityHeading(ped))
    QBCore.Functions.Progressbar("ep_nuoc_cam", "Đang ép nước cam", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@medic@standing@tendtodead@idle_a",
        anim = "idle_a",
        flags = 0,
    }, {}, {}, function() -- Done
        DeleteEntity(prop)
        DeleteEntity(prop2)
        ClearPedTasks(ped)   
        TriggerServerEvent('qb-haicam:server:epnuoccam')
    end, function() -- Cancel
        DeleteEntity(prop)
        DeleteEntity(prop2)
        ClearPedTasks(ped)
        QBCore.Functions.Notify('Đã hủy ép nước cam.', 'error', 5000)
    end)
end

function Bancam()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.9, -0.98))

    prop = CreateObject(GetHashKey('apa_mp_h_acc_fruitbowl_01'), x, y, z,  true,  true, true)
    SetEntityHeading(prop, GetEntityHeading(ped))
    QBCore.Functions.Progressbar("search_register", "Đang bán cam", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {
        animDict = "amb@medic@standing@tendtodead@idle_a",
        anim = "idle_a",
        flags = 0,
    }, {}, {}, function()
        ClearPedTasks(ped)
        DeleteEntity(prop)
        TriggerServerEvent('qb-haicam:server:bancam', 'bancam')
    end, function()
        ClearPedTasks(ped)
        DeleteEntity(prop)           
    end)
end

function Bannuoccamep()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.9, -0.98))

    prop = CreateObject(GetHashKey('beerrow_local'), x, y, z,  true,  true, true)
    SetEntityHeading(prop, GetEntityHeading(ped))
    QBCore.Functions.Progressbar("search_register", "Đang bán nước cam ép", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {
        animDict = "amb@medic@standing@tendtodead@idle_a",
        anim = "idle_a",
        flags = 0,
    }, {}, {}, function()
        ClearPedTasks(ped)
        DeleteEntity(prop)
        TriggerServerEvent('qb-haicam:server:bancam', 'bannuoccamep')
    end, function()
        ClearPedTasks(ped)
        DeleteEntity(prop)        
    end)
end

-- ################################################################################
--                                     EVENTS
-- ################################################################################

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('qb-haicam:client:epnuoccam', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        checkchairong = result
        s1d7 = true
    end, 'emptybottle')
    while(not s1d7) do
        Wait(100)
    end
    if (checkchairong) then
        Epnuoccam()
    else
        QBCore.Functions.Notify('Bạn không đủ chai rỗng.', 'error', 5000)
    end
end)

RegisterNetEvent('qb-haicam:client:bancam', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        checkcam = result
        s1d7 = true
    end, 'orange')
    while(not s1d7) do
        Wait(100)
    end
    if (checkcam) then
        Bancam()
    else
        QBCore.Functions.Notify('Bạn không có cam.', 'error', 5000)
    end
end)

RegisterNetEvent('qb-haicam:client:bannuoccamep', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        checknuoccamep = result
        s1d7 = true
    end, 'orangejuice')
    while(not s1d7) do
        Wait(100)
    end
    if (checknuoccamep) then
        Bannuoccamep()
    else
        QBCore.Functions.Notify('Bạn không có nước cam ép.', 'error', 5000)
    end
end)

-- ################################################################################
--                                   CreateThread
-- ################################################################################

CreateThread(function()
	for k, v in pairs(Config.Blips) do
        Wait(10000)
		v.blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(v.blip, v.id)
		SetBlipDisplay(v.blip, 4)
		SetBlipScale(v.blip, 0.8)
		SetBlipColour(v.blip, v.colour)
		SetBlipAsShortRange(v.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.title)
		EndTextCommandSetBlipName(v.blip)
	end
end)

CreateThread(function()
    while true do
        local time = 5000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for k, v in ipairs(Config.CongViec["vuoncam"]) do
            local dist = #(coords - v.coords)
            if dist < 10.0 then
                time = 3
                if dist < 3.0 then
                    DrawText3D(v.coords, "~g~E~w~ - Hái cam")
                    if IsControlJustReleased(0, 38) then
                        QBCore.Functions.Progressbar("hai_cam", "Đang hái cam", 5000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "amb@prop_human_movie_bulb@base",
                            anim = "base",
                            flags = 0,
                        }, {}, {}, function() -- Done 
                            ClearPedTasks(ped)   
                            TriggerServerEvent('qb-haicam:server:haicam')
                        end, function() -- Cancel
                            ClearPedTasks(ped)
                            QBCore.Functions.Notify('Đã hủy hái cam.', 'error', 5000)
                        end)
                    end
                end
            end
        end
        Wait(time)
    end
end)

CreateThread(function()
    while true do
        local time = 5000
        local ped = PlayerPedId()
        local coords  = GetEntityCoords(ped)
        local dist = #(coords - Config.CongViec["epnuoccam"].coords)

        if dist < 10.0 then
            time = 3
            if dist < 3.0 then
                DrawText3D(Config.CongViec["epnuoccam"].coords, '~g~E~w~ - Ép nước cam')        
                if IsControlJustReleased(0, 38) then
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                        checkcam = result
                        s1d7 = true
                    end, 'orange')
                    while(not s1d7) do
                        Wait(100)
                    end
                    if (checkcam) then
                        TriggerEvent('qb-haicam:client:epnuoccam')
                    else
                        QBCore.Functions.Notify('Bạn không có cam.', 'error', 5000)
                    end
                end
            end
        end
        Wait(time)
    end
end)

CreateThread(function()
    while true do
        local time = 5000
        local ped = PlayerPedId()
        local coords  = GetEntityCoords(ped)
        local dist = #(coords - Config.CongViec["chobancam"].coords)

        if dist < 10.0 then
            time = 3
            if dist < 3.0 then
                DrawText3D(Config.CongViec["chobancam"].coords, "~g~E~w~ - Bán cam, nước cam")
                if IsControlJustPressed(0, 38) then 
                    local Menu = {
                        {
                            header = "CHỢ BÁN CAM",
                            isMenuHeader = true
                        },
                        {
                            header = "Bán cam",
                            txt = "",
                            params = {
                                event = "qb-haicam:client:bancam"
                            }
                        },
                        {
                            header = "Bán nước cam ép",
                            txt = "",
                            params = {
                                event = "qb-haicam:client:bannuoccamep"
                            }
                        },
                        {
                            header = "⬅ Đóng Menu",
                            txt = "",
                            params = {
                                event = "qb-menu:client:closeMenu"
                            }
                        }
                    }
                    exports['qb-menu']:openMenu(Menu)
                end	
            end
        end
        Wait(time)
    end
end)