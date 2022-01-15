QBCore = exports['qb-core']:GetCoreObject()

-- ################################################################################
--                                       LOCAL
-- ################################################################################

local Blip                  = {}
local nhan_xe               = false
local dang_lam_viec         = false
local dia_diem_giao_hang    = nil
local dang_cam_pizza        = false
local so_pizza_da_giao      = 0
local bien_so               = nil

-- ################################################################################
--                                     FUNCTION
-- ################################################################################

local function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end

function LayXeGiaoPizza()
    local vehicleMenu = {
        {
            header = "XE GIAO PIZZA",
            isMenuHeader = true
        }
    }
    for veh, v in pairs(Config.CongViec["Xe"]) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.label,
            txt = "Máy: 100% | Vỏ: 100% | Xăng: 100%",
            params = {
                event = "qb-pizza:client:wxcWDhR-E4ZekekTZqezl-zhd3he3xmeq",
                args = {
                    model = v.model
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Đóng Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

function BlipDiemGiao()
    local randomLocation = math.random(1, #Config.DiaDiemGiaoHang)
    
    while (randomLocation == namecu) do
        Wait(10)
        randomLocation = math.random(1, #Config.DiaDiemGiaoHang)
    end

    dia_diem_giao_hang = Config.DiaDiemGiaoHang[randomLocation]["coords"]

    Blip['diemgiao'] = AddBlipForCoord(dia_diem_giao_hang)
    SetBlipRoute(Blip['diemgiao'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('[Giao Pizza] Điểm Giao Pizza')
	EndTextCommandSetBlipName(Blip['diemgiao'])
end

function BlipHoanThanh()
    Blip['ketthuc'] = AddBlipForCoord(Config.CongViec["KetThucGiaoHang"])
    SetBlipSprite(Blip['ketthuc'], 488)
    SetBlipDisplay(Blip['ketthuc'], 4)
    SetBlipScale(Blip['ketthuc'], 0.8)
    SetBlipAsShortRange(Blip['ketthuc'], true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('[Giao Pizza] Hoàn Thành Giao Pizza')
    EndTextCommandSetBlipName(Blip['ketthuc'])
end

function HanhDong()
    local ped = PlayerPedId()

    if not IsPedInAnyVehicle(ped, false) then
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            while not HasAnimDictLoaded("anim@heists@box_carry@") do
                RequestAnimDict("anim@heists@box_carry@")
                Wait(0)
            end
            if dang_cam_pizza then
                TaskPlayAnim( ped, "anim@heists@box_carry@", "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
                DetachEntity(prop, 1, 1)
                DeleteObject(prop)
                Wait(1000)
                ClearPedSecondaryTask(ped)
                dang_cam_pizza = false
            else
                local x,y,z = table.unpack(GetEntityCoords(ped))

                prop = CreateObject(GetHashKey('prop_pizza_box_01'), x, y, z+0.2,  true,  true, true)
                AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 60309), 0.2, 0.08, 0.2, -45.0, 290.0, 0.0, true, true, false, true, 1, true)
                TaskPlayAnim( ped, "anim@heists@box_carry@", "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                dang_cam_pizza = true
            end
        end
    end
end

function GiaoPizza()
    so_pizza_da_giao = so_pizza_da_giao + 1
    QBCore.Functions.Notify("Giao hàng thành công. Bạn đã giao được "..so_pizza_da_giao.." điểm giao pizza.","success")
    dang_cam_pizza = false
    RemoveBlip(Blip['diemgiao'])
    BlipDiemGiao()
end

-- ################################################################################
--                                     EVENTS
-- ################################################################################

RegisterNetEvent('qb-pizza:client:wxcWDhR-E4ZekekTZqezl-zhd3he3xmeq', function(data)
    if nhan_xe == true then
        QBCore.Functions.Notify("Bạn đã nhận xe giao pizza rồi.", "error")
    elseif nhan_xe == false then
        QBCore.Functions.TriggerCallback('qb-pizza:callback:oI13P0jheehq-HPkIlqOVdamBM-sqjjWMVAg', function(checkmoney, plate)
            if checkmoney then
                QBCore.Functions.SpawnVehicle(data.model, function(veh)
                    SetVehicleNumberPlateText(veh, plate)
                    exports['LegacyFuel']:SetFuel(veh, 100.0)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, Config.CongViec["DiemNhanXe"], true)
                bien_so = plate
                nhan_xe = true
                dang_lam_viec = true
                QBCore.Functions.Notify("Điểm giao pizza đã được đánh dấu trên map của bạn.","success")
                BlipDiemGiao()
                BlipHoanThanh()
            end
        end, true, "")
    end
end)

RegisterNetEvent('qb-pizza:client:EbcIdnsPDHm-KRhXPeKO0-iQca7hi', function()
    if nhan_xe == true then
        local ped = PlayerPedId()
        local veh2 = GetVehiclePedIsIn(ped)
        local Plate = QBCore.Functions.GetPlate(veh2)

        QBCore.Functions.TriggerCallback('qb-pizza:callback:oI13P0jheehq-HPkIlqOVdamBM-sqjjWMVAg', function(checkmoney, plate)
            if checkmoney then
                TriggerServerEvent('qb-pizza:server:53lSHqXmUpkJb4o-871g5AEBy4C-0vY5gaSVZqfMO', so_pizza_da_giao)
                RemoveBlip(Blip['diemgiao'])
                RemoveBlip(Blip['ketthuc'])
                dang_lam_viec = false
                dang_cam_pizza = false
                so_pizza_da_giao = 0
                nhan_xe = false
                DeleteVehicle(veh2)
            end
        end, false, Plate)
    elseif nhan_xe == false then
        QBCore.Functions.Notify("Bạn chưa nhận xe giao pizza.", "error")
    end
end)

-- ################################################################################
--                                   CreateThread
-- ################################################################################

CreateThread(function()
    Wait(10000)
    Blips = AddBlipForCoord(Config.CongViec["DiemLayXe"])
    SetBlipSprite(Blips, 488)
    SetBlipDisplay(Blips, 4)
    SetBlipScale(Blips, 0.8)
    SetBlipAsShortRange(Blips, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Cửa Hàng Pizza')
    EndTextCommandSetBlipName(Blips)
end)

CreateThread(function()
    while true do
        local time = 5000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist1 = #(pos - Config.CongViec["DiemLayXe"])
        
        if dist1 < 10 then
            time = 3
            if dist1 < 3 then
                local GaragePos = Config.CongViec["DiemLayXe"]

                DrawText3D(GaragePos.x, GaragePos.y, GaragePos.z, "~g~E~s~ - Bắt đầu công việc")
                if IsControlJustReleased(0, 46) then
                    LayXeGiaoPizza()
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
        local pos = GetEntityCoords(ped)

        if dang_lam_viec == true then
            local dist3 = #(pos - dia_diem_giao_hang)

            if dist3 < 25 then
                time = 3
                if not dang_cam_pizza then
                    local Vehicle = GetClosestVehicle(pos, 6.0, 0, 70)

                    DrawText3D(dia_diem_giao_hang.x, dia_diem_giao_hang.y, dia_diem_giao_hang.z, "Điểm giao ~y~pizza~w~")
                    if QBCore.Functions.GetPlate(Vehicle) == bien_so and not IsPedInAnyVehicle(ped, false) then
                        local Veh = GetEntityCoords(Vehicle)
                        local dist4 = #(pos - Veh)

                        DrawText3D(Veh.x, Veh.y, Veh.z, "~g~E~w~ - Lấy pizza")
                        if dist4 < 3 then
                            if IsControlJustReleased(0, 46) then
                                HanhDong()
                            end
                        end
                    end
                else
                    if not IsPedInAnyVehicle(ped, false) then
                        DrawText3D(dia_diem_giao_hang.x, dia_diem_giao_hang.y, dia_diem_giao_hang.z, "~g~E~w~ - Giao pizza")
                        if dist3 < 3 then
                            if IsControlJustReleased(0, 46) then
                                HanhDong()
                                GiaoPizza()
                            end
                        end
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
        local pos = GetEntityCoords(ped)
        local dist2 = #(pos - Config.CongViec["KetThucGiaoHang"])

        if dist2 < 10 then
            time = 3
            if dist2 < 3 then
                local endPoint = Config.CongViec["KetThucGiaoHang"]

                if IsPedInAnyVehicle(ped, false) then
                    DrawText3D(endPoint.x,endPoint.y,endPoint.z, "~g~E~w~ - Hoàn thành giao pizza")
                    if IsControlJustReleased(0, 46) then
                        TriggerEvent('qb-pizza:client:EbcIdnsPDHm-KRhXPeKO0-iQca7hi')
                    end
                end
            end
        end
        Wait(time)
    end
end)