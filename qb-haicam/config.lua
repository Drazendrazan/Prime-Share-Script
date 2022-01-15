Config = {}

-- SẢN LƯỢNG CAM TOÀN SERVER ĐƯỢC HÁI MỖI NGÀY
Config.SanLuongCamMoiNgay = 1500

-- HÁI CAM
Config.SoCamHaiDuoc = { -- Số cam hái được random từ 1->5
	1, 5
}

-- ÉP NƯỚC CAM
Config.DungCuEpNuocCam = {
	['cam']       = 1,  -- Số lượng cam cần để ép nước cam
	['chairong']  = 1,  -- Số lượng chai rỗng cần để ép nước cam
	['nuoccamep'] = 1   -- Số lượng nước cam ép nhận được
}

-- BÁN CAM - NƯỚC CAM ÉP
Config.BanSanPham = {
	['cam']       = {5, 10},
	['nuoccamep'] = {5, 10}
}

-- HÌNH TRÊN MAP
Config.Blips = {
	{title="[Hái Cam] Vườn Cam",     colour=47, id=467, x = 354.81,  y = 6517.49, z = 28.24},
    {title="[Hái Cam] Ép Nước Cam",  colour=47, id=467, x = 404.26,  y = 6526.37, z = 27.7},
    {title="[Hái Cam] Bán Nước Cam", colour=47, id=467, x = 2741.65, y = 4412.24, z = 48.62}
}

-- TỌA ĐỘ CÁC ĐIỂM LÀM VIỆC
Config.CongViec = {
	["vuoncam"] = {
		{coords = vector3(322.40505, 6505.5073, 29.168262)},
		{coords = vector3(322.29101, 6517.247, 29.123582)},
		{coords = vector3(321.99127, 6530.7187, 29.16489)},
		{coords = vector3(331.40173, 6506.0087, 28.513591)},
		{coords = vector3(330.79446, 6517.8325, 28.951513)},
		{coords = vector3(329.9681, 6530.9594, 28.580907)},
		{coords = vector3(340.07116, 6505.7866, 28.695077)},
		{coords = vector3(339.43643, 6517.1074, 28.952114)},
		{coords = vector3(339.11148, 6531.1557, 28.568105)},
		{coords = vector3(348.29681, 6505.5161, 28.79372)},
		{coords = vector3(348.06353, 6517.4853, 28.746948)},
		{coords = vector3(346.4244, 6531.3339, 28.680498)},
		{coords = vector3(355.87173, 6505.2377, 28.468915)},
		{coords = vector3(355.92318, 6517.2368, 28.148246)},
		{coords = vector3(354.25836, 6530.7548, 28.360443)},
		{coords = vector3(363.45822, 6506.0341, 28.542383)},
		{coords = vector3(363.07659, 6517.7236, 28.283466)},
		{coords = vector3(361.73477, 6531.0292, 28.358283)},
		{coords = vector3(370.35546, 6506.3476, 28.415504)},
		{coords = vector3(363.18997, 6517.9008, 28.28902)},
		{coords = vector3(361.95465, 6531.3496, 28.346151)},
		{coords = vector3(370.54425, 6506.1855, 28.402412)},
		{coords = vector3(370.45718, 6517.5048, 28.372945)},
		{coords = vector3(369.96704, 6532.0205, 28.365488)},
		{coords = vector3(378.18902, 6506.2163, 27.96578)},
		{coords = vector3(378.16403, 6518.0229, 28.360092)}
	},
	["epnuoccam"] = {
		coords = vector3(405.52517, 6526.184, 27.693988)
	},
	["chobancam"] = {
		coords = vector3(2741.7607, 4412.4951, 48.623241)
	}
}