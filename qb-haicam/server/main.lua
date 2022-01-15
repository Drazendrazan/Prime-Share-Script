QBCore = exports['qb-core']:GetCoreObject()

-- ################################################################################
--                                       LOCAL
-- ################################################################################

local thongbaohetsanluong       = false
local thongbaoconmotnuasanluong = false

-- ################################################################################
--                         KIỂM TRA - CẬP NHẬT SẢN LƯỢNG CAM
-- ################################################################################

function kiemtrasoluong(src, soluong)
    exports.oxmysql:fetch('SELECT * FROM player_congviec WHERE congviec = ?', {'cam'}, function(result)

        if result[1].soluong <= (Config.SanLuongCamMoiNgay/2) then
            if thongbaoconmotnuasanluong == false then
                thongbaoconmotnuasanluong = true
                TriggerClientEvent('chatMessage', -1, "VƯỜN CAM", "error", 'Sản lượng cam tại vườn chỉ còn một nửa.')
            end
        end

        if result[1].soluong <= 0 then
            if thongbaohetsanluong == false then
                thongbaohetsanluong = true
                TriggerClientEvent('chatMessage', -1, "VƯỜN CAM", "error", 'Sản lượng cam tại vườn đã hết.')
            end
            capnhatsanluongcam()
            TriggerClientEvent('QBCore:Notify', src, 'Sản lượng cam hôm nay đã được thu hoạch hết.', "error", 5000)
        else
            if result[1].soluong >= soluong then
                haicam(src, soluong)
            else
                haicam(src, result[1].soluong)
            end
        end
    end)
end

function capnhatsoluong(amount)
    exports.oxmysql:fetch('SELECT * FROM player_congviec WHERE congviec = ?', {'cam'}, function(result)
        local trucam = result[1].soluong - amount

        if result[1].soluong < 0 then
            exports.oxmysql:execute('UPDATE player_congviec SET soluong = ? WHERE congviec = ?', { 0, 'cam' })
        end
        exports.oxmysql:execute('UPDATE player_congviec SET soluong = ? WHERE congviec = ?', { trucam, 'cam' })
    end)
end

function capnhatsanluongcam()
    local timehientai = tonumber(os.time())

    exports.oxmysql:fetch('SELECT * FROM player_congviec WHERE congviec = ?', {'cam'}, function(result)
        if result[1].thoigian + 86400 <= timehientai  then
            exports.oxmysql:execute('UPDATE player_congviec SET soluong = ? WHERE congviec = ?', { Config.SanLuongCamMoiNgay, 'cam' })
            TriggerClientEvent('chatMessage', -1, "VƯỜN CAM", "success", 'Vườn cam có một sản lượng lớn cần thu hoạch.')
        end
    end)
end

function haicam(src, soluong)
    local Player = QBCore.Functions.GetPlayer(src)

    capnhatsoluong(soluong)
    Player.Functions.AddItem('orange', soluong)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['orange'], "add", soluong)
end

-- ################################################################################
--                                   HÁI CAM
-- ################################################################################

RegisterNetEvent('qb-haicam:server:haicam', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Random = math.random(Config.SoCamHaiDuoc[1], Config.SoCamHaiDuoc[2])

    kiemtrasoluong(src, Random)
end)

-- ################################################################################
--                                  ÉP NƯỚC CAM
-- ################################################################################

RegisterNetEvent('qb-haicam:server:epnuoccam', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CheckCam = Player.Functions.GetItemByName('orange')
    local CheckChaiRong = Player.Functions.GetItemByName('emptybottle')

    if CheckCam == nil or CheckChaiRong == nil then
        TriggerClientEvent('QBCore:Notify', src, 'Bạn không có cam hoặc chai rỗng.', "error", 5000)
        return
    end

    if CheckCam.amount >= Config.DungCuEpNuocCam['cam'] then
        if CheckChaiRong.amount >= Config.DungCuEpNuocCam['chairong'] then
            -- Trừ cam
            Player.Functions.RemoveItem('orange', Config.DungCuEpNuocCam['cam'])
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['orange'], "remove", Config.DungCuEpNuocCam['cam'])
            -- Trừ chai rỗng
            Player.Functions.RemoveItem('emptybottle', Config.DungCuEpNuocCam['chairong'])
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['emptybottle'], "remove", Config.DungCuEpNuocCam['chairong'])
            -- Cộng nước cam ép
            Player.Functions.AddItem('orangejuice', Config.DungCuEpNuocCam['nuoccamep'])
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['orangejuice'], "add", Config.DungCuEpNuocCam['nuoccamep'])
        else
            TriggerClientEvent('QBCore:Notify', src, 'Bạn không đủ chai rỗng.', "error", 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Bạn không đủ cam.', "error", 5000)
    end
end)

-- ################################################################################
--                              BÁN CAM - NƯỚC CAM ÉP
-- ################################################################################

RegisterNetEvent('qb-haicam:server:bancam', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if type == 'bancam' then
        local Item = Player.Functions.GetItemByName('orange')
        local reward = math.random(Config.BanSanPham['cam'][1], Config.BanSanPham['cam'][2]) * Item.amount

        if Item ~= nil then
            if Item.amount > 0 then
                -- Trừ cam
                Player.Functions.RemoveItem('orange', Item.amount)
                TriggerClientEvent("qb-inventory:client:ItemBox", src, QBCore.Shared.Items['orange'], "remove", Item.amount)
                -- Cộng tiền
                Player.Functions.AddMoney("cash", reward, "sold-pawn-items")
                TriggerClientEvent('QBCore:Notify', src, 'Bạn đã bán cam được: $'..reward, "success", 5000)  
            else
                TriggerClientEvent('QBCore:Notify', src, 'Bạn không đủ cam.', "error")  
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'Bạn không có cam.', "error")  
        end
    elseif type == 'bannuoccamep' then
        local Item = Player.Functions.GetItemByName('orangejuice')
        local reward = math.random(Config.BanSanPham['nuoccamep'][1], Config.BanSanPham['nuoccamep'][2]) * Item.amount

        if Item ~= nil then
            if Item.amount > 0 then
                -- Trừ cam
                Player.Functions.RemoveItem('orangejuice', Item.amount)
                TriggerClientEvent("qb-inventory:client:ItemBox", src, QBCore.Shared.Items['orangejuice'], "remove", Item.amount)
                -- Cộng tiền
                Player.Functions.AddMoney("cash", reward, "sold-pawn-items")
                TriggerClientEvent('QBCore:Notify', src, 'Bạn đã bán nước cam ép được: $'..reward, "success", 5000)  
            else
                TriggerClientEvent('QBCore:Notify', src, 'Bạn không đủ nước cam ép.', "error")  
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'Bạn không có nước cam ép.', "error")  
        end
    end
end)