Config = {}

-- Blip
Config.ChoBanCa = { -- Chợ Cá | Fish Market
    ["name"] = "Chợ Cá", -- Tên Blip | Blip Name
    ["blip"] = {
        ["sprite"] = 68, -- Hình Blip | Blip Sprite
        ["color"] = 2    -- Màu Blip | Blip Color
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6, -- Model Ped
        ["position"] = vector3(-1038.4545898438, -1397.0551757813, 5.553192615509), -- Vị Trí Ped | Ped Position
        ["heading"] = 75.0 -- Hướng Mặt Ped | Ped Heading
    }
}

Config.ViTriCau = { -- Vị Trí Câu Cá | Fishing Location
    ["blip"] = {
        ["sprite"] = 68, -- Hình Blip | Blip Sprite
        ["color"] = 2    -- Màu Blip | Blip Color
    }
}

Config.ThoiGianCanCau = { -- Thời gian cá cắn câu | Time for fish to bite the hook
    [1] = 10000,
    [2] = 30000
}

Config.DungCuCauCa = {
    -- Cần câu | Fishing rod
    ["rod"] = {
        ["name"] = "fishingrod",
        ["label"] = "Cần câu"
    },
    -- Mồi câu | Fishing bait
    ["bait"] = {
        ["name"] = "fishingbait",
        ["label"] = "Mồi câu"
    },
    -- Giá bán cá | Fish selling price
    ["fish"] = {
        ["price"] = 25 
    },
    ["stripedbass"] = {
        ["price"] = 50
    },
    ["bluefish"] = {
        ["price"] = 50
    },
    ["redfish"] = {
        ["price"] = 100 
    },
    ["pacifichalibut"] = {
        ["price"] = 100 
    },
    ["goldfish"] = {
        ["price"] = 100
    },
    ["dolphinmeat"] = {
        ["price"] = 500
    },
    ["sharktigermeat"] = {
        ["price"] = 500
    },
    ["sharkhammermeat"] = {
        ["price"] = 500
    },
    ["stingraymeat"] = {
        ["price"] = 500
    },
    ["killerwhalemeat"] = {
        ["price"] = 1000
    },
    ["humpbackmeat"] = {
        ["price"] = 1000
    },
}

Config.KhuVucCauCa = { -- Khu vực câu cá | Fishing area (random)
    [1] = {
        ["name"]   = "Cau_1",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(-1948.12, -749.79, 2.54),
        ["radius"] = 50.0,
    },
    [2] = {
        ["name"]   = "Cau_2",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(1311.57, 4228.83, 33.91),
        ["radius"] = 50.0,
    },
    [3] = {
        ["name"]   = "Cau_3",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(1525.05, 3908.90, 30.79),
        ["radius"] = 50.0,
    },
    [4] = {
        ["name"]   = "Cau_4",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(2223.69, 4575.70, 31.23),
        ["radius"] = 50.0,
    },
    [5] = {
        ["name"]   = "Cau_5",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(31.98, 4294.77, 31.23),
        ["radius"] = 50.0,
    },
    [6] = {
        ["name"]   = "Cau_6",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(-1835.03, -1820.41, 3.67),
        ["radius"] = 200.0,
    },
    [7] = {
        ["name"]   = "Cau_7",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(-722.52, 7188.61, 1.85),
        ["radius"] = 200.0,
    },
    [8] = {
        ["name"]   = "Cau_8",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(3469.17, 1271.29, 1.36),
        ["radius"] = 200.0,
    },
    [9] = {
        ["name"]   = "Cau_9",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(-3277.41, 2613.34, 1.62),
        ["radius"] = 200.0,
    },
    [10] = {
        ["name"]   = "Cau_10",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(7040.34, 8172.63, 204.43),
        ["radius"] = 500.0,
    },
    [11] = {
        ["name"]   = "Cau_11",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(3194.11, 906.83, 442.03),
        ["radius"] = 10.0,
    },
    [12] = {
        ["name"]   = "Cau_12",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(-3081.51, 4007.41, 201.00),
        ["radius"] = 10.0,
    },
    [13] = {
        ["name"]   = "Cau_13",
        ["label"]  = "Khu vực câu cá",
        ["coords"] = vector3(-2523.37, 7160.87, 200.27),
        ["radius"] = 10.0,
    }
}

Config.Locales = {
    -- Notify
    ["dang_duoi_nuoc"]     = "Bạn không thể bơi và câu cá cùng một lúc.",
    ["dang_trong_xe"]      = "Bạn cần thoát khỏi xe của bạn để bắt đầu câu cá.",
    ["thieu_cong_cu"]      = "Bạn thiếu cần câu và mồi câu cá.",
    ["dung_qua_xa"]        = "Bạn đứng quá xa khu vực câu.",
    ["het_moi_cau"]        = "Bạn không còn mồi câu!",
    ["ngung_cau"]          = "Bạn đã ngừng câu cá.",
    ["dung_qua_lau"]       = "Bạn đã ngừng câu vì đứng im quá lâu.",
    ["doi_ca_can_cau"]     = "Đợi cá cắn câu...",
    ["cau_hut"]            = "Bạn đã để tuột cá.",
    ["dung_ngoai_vung"]    = "Bạn đứng ngoài vùng câu cá.",
    ["chua_nhan_diem"]     = "Đến chợ cá nhận điểm câu cá.",
    ["da_them_diem"]       = "Khu vực câu cá đã được hiển thị trên map của bạn.",

    -- 3d text
    ["nhan_diem_cau"]      = "~g~E~s~ - Bán cá\n~g~G~s~ - Nhận điểm câu cá",
    ["nguoi_mua_bat_tinh"] = "Người mua cá đã bất tỉnh, quay lại sau",
    ["giat_can"]           = "~g~%s~w~ - Giật cần câu",
    ["cau_va_ngung_cau"]   = "~g~G~w~ - Câu cá\n~r~X~w~ - Dừng câu cá"
}

-- Locales EN

-- Config.Locales = {
--     -- Notify
--     ["dang_duoi_nuoc"]     = "You cannot swim and fish at the same time.",
--     ["dang_trong_xe"]      = "You need to get rid of your car to start fishing.",
--     ["thieu_cong_cu"]      = "You lack fishing rods and fishing lures.",
--     ["dung_qua_xa"]        = "You are standing too far away from the fishing area.",
--     ["het_moi_cau"]        = "You have no more bait!",
--     ["ngung_cau"]          = "You have stopped fishing.",
--     ["dung_qua_lau"]       = "You stopped fishing because you stood still for too long.",
--     ["doi_ca_can_cau"]     = "Waiting for the fish to bite...",
--     ["cau_hut"]            = "You let the fish slip.",
--     ["dung_ngoai_vung"]    = "You are outside the fishing area.",
--     ["chua_nhan_diem"]     = "Go to the fish market to get fishing points.",
--     ["da_them_diem"]       = "The fishing area has been displayed on your map.",

--     -- 3d text
--     ["nhan_diem_cau"]      = "~g~E~s~ - Sell ​​fish\n~g~G~s~ - Get fishing points",
--     ["nguoi_mua_bat_tinh"] = "The fish buyer lost consciousness, come back later",
--     ["giat_can"]           = "%s - Pull the fishing rod",
--     ["cau_va_ngung_cau"]   = "~g~G~w~ - Go fishing\n~r~X~w~ - Stop fishing"
-- }