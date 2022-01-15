QBCore = exports['qb-core']:GetCoreObject()

-- ################################################################################
--                                     LOCAL
-- ################################################################################

local Bail        = {}
local plate       = nil

-- ################################################################################
--                                    CALLBACK
-- ################################################################################

QBCore.Functions.CreateCallback('qb-pizza:callback:oI13P0jheehq-HPkIlqOVdamBM-sqjjWMVAg', function(source, cb, check, Plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid

    if check then
        plate = "PIZZA" .. math.random(100, 999)
        if Player.PlayerData.money.cash >= Config.CongViec["TienThueXe"] then
            Bail[CitizenId] = "cash"
            Player.Functions.RemoveMoney('cash', Config.CongViec["TienThueXe"], "Nghề giao pizza - cọc thuê xe")
            TriggerClientEvent('QBCore:Notify', src, "Bạn đã trả: $"..Config.CongViec["TienThueXe"].." cọc thuê xe.", 'success')
            cb(true, plate)
        elseif Player.PlayerData.money.bank >= Config.CongViec["TienThueXe"] then
            Bail[CitizenId] = "bank"
            Player.Functions.RemoveMoney('bank', Config.CongViec["TienThueXe"], "Nghề giao pizza - cọc thuê xe")
            TriggerClientEvent('QBCore:Notify', src, "Bạn đã trả: $"..Config.CongViec["TienThueXe"].." cọc thuê xe.", 'success')
            cb(true, plate)
        else
            TriggerClientEvent('QBCore:Notify', src, "Bạn không có đủ $"..Config.CongViec["TienThueXe"].." cọc thuê xe.", 'error')
            cb(false, plate)
        end
    else
        if Plate == plate then
            if Bail[CitizenId] ~= nil then
                Player.Functions.AddMoney(Bail[CitizenId], Config.CongViec["TienThueXe"], "Nghề giao pizza - cọc thuê xe")
                Bail[CitizenId] = nil
                TriggerClientEvent('QBCore:Notify', src, "Bạn nhận được: $"..Config.CongViec["TienThueXe"].." cọc thuê xe.", 'success') 
                cb(true, plate)
            else
                TriggerClientEvent('QBCore:Notify', src, "Bạn không có khoản đặt cọc nào được trả cho phương tiện này.", 'error')
                cb(false, plate)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Đây không phải xe chúng tôi cho bạn thuê.", 'error')
            cb(false, plate)
        end
    end
end)

-- ################################################################################
--                                      EVENT
-- ################################################################################

RegisterNetEvent('qb-pizza:server:53lSHqXmUpkJb4o-871g5AEBy4C-0vY5gaSVZqfMO', function(drops)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randomAmount = math.random(1, 5)
    local r1, r2 = math.random(1, 5), math.random(1, 5)
    local bonus = 0
    local salary = drops * math.random(Config.CongViec["TienLuong"][1], Config.CongViec["TienLuong"][2])

    if drops > 5 then
        if randomAmount == r1 or randomAmount == r2 then
            bonus = math.random(10, 20)
            salary = salary + bonus
        end
    end

    local taxAmount = math.ceil((salary / 100) * Config.CongViec["TienThue"])
    local Payment = salary - taxAmount

    Player.Functions.AddMoney('cash', Payment, "Nghề giao pizza - lương")
    TriggerClientEvent('chatMessage', source, "NGHỀ GIAO PIZZA", "warning", "Bạn đã nhận được $"..Payment.." tiền vé.\nTổng: $"..salary.." | Thưởng $"..bonus.." | Thuế $"..taxAmount.." ("..Config.CongViec["TienThue"].."%)")
end)