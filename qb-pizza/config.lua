Config              = {}

Config.CongViec = {
	["DiemLayXe"]       = vector3(538.17, 101.61, 96.63),             -- Điểm nhận xe bắt đầu công việc
	["DiemNhanXe"]      = vector4(535.02, 94.72, 96.30, 163.29),      -- Điểm xe spawn ra khi nhận xe
	["KetThucGiaoHang"] = vector3(546.91668, 92.219223, 96.268379),   -- Điểm trả xe + nhận lương

    ["Xe"]              = {                                           -- Xe để đi giao pizza
        [1] = {model = "faggio2", label = "Xe máy"},
        [2] = {model = "vwcaddy", label = "Ô tô"}
    }, 

    ["TienThueXe"]      = 100,                                        -- Tiền thuê xe
    ["TienLuong"]       = {30, 50},                                   -- Tiền lương (random từ 30 đến 50 rồi nhân với số chuyến pizza đã giao)
    ["TienThue"]        = 15                                          -- Tiền thuế (15%. sẽ bị trừ đi 15% lương khi nhận lương)
}

Config.DiaDiemGiaoHang = { -- Địa điểm giao pizza random
    -- Cách thêm điểm giao pizza mới
    -- [0] = {                                                        -- Số thứ tự (không được trùng nhau)
    --     ["name"]   = "Giao_1",  
    --     ["label"]  = "Địa điểm giao pizza",
    --     ["coords"] = vector3(3.4530751, 36.729873, 71.524269),     -- Vị trí giao pizza
    --     ["radius"] = 10.0,
    -- },
    [1] = {
        ["name"]   = "Giao_1",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(3.4530751, 36.729873, 71.524269),
        ["radius"] = 10.0,
    },
    [2] = {
        ["name"]   = "Giao_2",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-273.5766, 28.319887, 54.745944),
        ["radius"] = 10.0,
    },
    [3] = {
        ["name"]   = "Giao_3",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-345.0465, 18.219902, 47.852313),
        ["radius"] = 10.0,
    },
    [4] = {
        ["name"]   = "Giao_4",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-534.28, 33.182659, 44.577846),
        ["radius"] = 10.0,
    },
    [5] = {
        ["name"]   = "Giao_5",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-842.2208, -25.0797, 40.391666),
        ["radius"] = 10.0,
    },
    [6] = {
        ["name"]   = "Giao_6",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-902.4472, 191.71932, 69.446022),
        ["radius"] = 10.0,
    },
    [7] = {
        ["name"]   = "Giao_7",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-1116.81, 304.53021, 66.514762),
        ["radius"] = 10.0,
    },
    [8] = {
        ["name"]   = "Giao_8",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(45.088817, -30.02272, 69.394744),
        ["radius"] = 10.0,
    },
    [9] = {
        ["name"]   = "Giao_9",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-1961.236, 212.01458, 86.801887),
        ["radius"] = 10.0,
    },
    [10] = {
        ["name"]   = "Giao_10",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-1961.23, 212.01, 86.8),
        ["radius"] = 10.0,
    },
    [11] = {
        ["name"]   = "Giao_11",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-1447.206, -537.9046, 34.740303),
        ["radius"] = 10.0,
    },
    [12] = {
        ["name"]   = "Giao_12",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(126.66783, -1929.797, 21.381532),
        ["radius"] = 10.0,
    },
    [13] = {
        ["name"]   = "Giao_13",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-5.061714, -1872.062, 24.15018),
        ["radius"] = 10.0,
    },
	[14] = {
        ["name"]   = "Giao_14",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-80.68806, -1608.084, 31.480993),
        ["radius"] = 10.0,
    },
	[15] = {
        ["name"]   = "Giao_15",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-61.16952, -1093.536, 26.493232),
        ["radius"] = 10.0,
    },
	[16] = {
        ["name"]   = "Giao_16",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(344.72683, -205.037, 58.012775),
        ["radius"] = 10.0,
    },
	[17] = {
        ["name"]   = "Giao_17",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(340.95178, -214.886, 58.01247),
        ["radius"] = 10.0,
    },
	[18] = {
        ["name"]   = "Giao_18",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(337.12786, -224.7219, 58.012996),
        ["radius"] = 10.0,
    },
	[19] = {
        ["name"]   = "Giao_19",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(331.40649, -225.7761, 58.012523),
        ["radius"] = 10.0,
    },
	[20] = {
        ["name"]   = "Giao_20",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(337.15399, -224.7381, 54.215591),
        ["radius"] = 10.0,
    },
	[21] = {
        ["name"]   = "Giao_21",
        ["label"]  = "Địa điểm giao pizza",
        ["coords"] = vector3(-386.8203, 504.26181, 120.40672),
        ["radius"] = 10.0,
    },
}