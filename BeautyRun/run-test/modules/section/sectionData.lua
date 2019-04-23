-- 设置多个不同的场景模板,会随机选择一个场景进行设置

local M = {}

M = {
	-----------------------------------
	-- 第一个场景的内容.
	-----------------------------------
	{
		-- 平台
		platforms = {
			--{
			--	type = "Large",
			--	widthHeight = { 452, 226 },
			--	nilHeight = 77,
			--	position = { 1100, 500 },
			--	screen = 1,
			--},
			{
				type = "Small", --平台的类型.[Tiny,Small,Med,Large,Comm五种]
				widthHeight = { 198, 384 }, --图片的宽/高[每种平台的图片宽高]
				nilHeight = 115, --树木高度像素,为模型无效值[图片中树木等的高度]
				position = { -20, 400 }, -- 图片在屏幕中的显示位置
				screen = 1, -- 数值每变大1,向右移动480像素(根据config.lua的配置为向右移动一个内容的宽度)
			},
			{
				type = "Comm",
				widthHeight = { 450, 236 },
				nilHeight = 56,
				position = { 370, 500 },
				screen = 1,
			},
			{
				type = "Med",
				widthHeight = { 290, 290 },
				nilHeight = 95,
				position = { 800, 550 },
				screen = 1,
			},
			{
				type = "Tiny",
				widthHeight = { 136, 106 },
				nilHeight = 16,
				position = { 1100, 500 },
				screen = 1,
			},
		},

		--金币形态[position位置]
		golds = {
			{ position = { 240, 360 }, screen = 1 },
			{ position = { 280, 360 }, screen = 1 },
			{ position = { 100, 340 }, screen = 2 },
			{ position = { 140, 320 }, screen = 2 },
			{ position = { 180, 300 }, screen = 2 },
			{ position = { 220, 280 }, screen = 2 },
			{ position = { 260, 260 }, screen = 2 },
			{ position = { 300, 280 }, screen = 2 },
			{ position = { 340, 300 }, screen = 2 },
			{ position = { 380, 320 }, screen = 2 },
			{ position = { 420, 340 }, screen = 2 },
		},

		-- 道具 提供增益状态[type:道具名称和种类]
		Props = {
			-- 红药
			{
				type = "redPill",
				widthHeight = { 63, 67 },
				position = { 200, 450 },
				screen = 1
			},

			-- --蓝药
			--{
			--	type = "bluePill",
			--	widthHeight = { 63, 67 },
			--	position = { 200, 450 },
			--	screen = 1
			--},

			---- 钱袋
			--{
			--	type = "adsorption",
			--	widthHeight = { 50, 54 },
			--	position = { 200, 450 },
			--	screen = 1
			--},

			-- 盾牌
			--{
			--	type = "shield",
			--	widthHeight = { 88, 115 },
			--	position = {200, 450},
			--	screen = 1
			--},

			--体型变大
			--{
			--	type = "bigPill",
			--	widthHeight = { 50, 54 },
			--	position = { 200, 450 },
			--	screen = 1
			--},

			-- 冲刺
			{
				type = "star",
				widthHeight = { 38, 41 },
				position = { 350, 400 },
				screen = 1
			},
		},
	},


	-------------------------------------
	----第二个场景
	-------------------------------------
	{
		-- 平台
		platforms = {
			{
				type = "Large",
				widthHeight = { 452, 226 },
				nilHeight = 77,
				position = { 50, 500 },
				screen = 1,
			},
			--{
			--	type = "Small", --平台的类型.[Tiny,Small,Med,Large,Comm五种]
			--	widthHeight = { 198, 384 }, --图片的宽/高[每种平台的图片宽高]
			--	nilHeight = 115, --树木高度像素,为模型无效值[图片中树木等的高度]
			--	position = { -20, 400 }, -- 图片在屏幕中的显示位置
			--	screen = 1, -- 数值每变大1,向右移动480像素(根据config.lua的配置为向右移动一个内容的宽度)
			--},
			{
				type = "Comm",
				widthHeight = { 450, 236 },
				nilHeight = 56,
				position = { 660, 400 },
				screen = 1,
			},
			--{
			--	type = "Med",
			--	widthHeight = { 290, 290 },
			--	nilHeight = 95,
			--	position = { 1100, 500 },
			--	screen = 1,
			--},
			{
				type = "Tiny",
				widthHeight = { 136, 106 },
				nilHeight = 16,
				position = { 1100, 500 },
				screen = 1,
			},
		},

		golds = {
			{ position = { -40,  520 }, screen = 1 },
			{ position = { 0, 520 }, screen = 1 },
			{ position = { 40, 520 }, screen = 1 },
			{ position = { 80, 520 }, screen = 1 },
			{ position = { 120, 520 }, screen = 1 },
			{ position = { 160, 520 }, screen = 1 },
			{ position = { -300, 400 }, screen = 2 },
			{ position = { -340, 400 }, screen = 2 },
			{ position = { -380, 360 }, screen = 2 },
			{ position = { -420, 400 }, screen = 2 },
			{ position = { -460, 400 }, screen = 2 },
		},

		-- 道具 提供增益状态[type:道具名称和种类]
		Props = {
			---- 红药
			--{
			--	type = "redPill",
			--	widthHeight = { 63, 67 },
			--	position = { 1100, 450 },
			--	screen = 1
			--},

			 -- 蓝药
			{
				type = "bluePill",
				widthHeight = { 63, 67 },
				position = { 200, 450 },
				screen = 1
			},

			---- 钱袋
			--{
			--	type = "adsorption",
			--	widthHeight = { 50, 54 },
			--	position = { 200, 450 },
			--	screen = 1
			--},

			-- 盾牌
			{
				type = "shield",
				widthHeight = { 88, 115 },
				position = { 260, 400},
				screen = 1
			},

			--体型变大
			--{
			--	type = "bigPill",
			--	widthHeight = { 50, 54 },
			--	position = { 200, 450 },
			--	screen = 1
			--},

			-- 冲刺
			--{
			--	type = "star",
			--	widthHeight = { 38, 41 },
			--	position = { 350, 400 },
			--	screen = 1
			--},
		},
	},


	-------------------------------------
	----第三个场景
	-------------------------------------
	{
		-- 平台
		platforms = {
			--{
			--	type = "Large",
			--	widthHeight = { 452, 226 },
			--	nilHeight = 77,
			--	position = { 50, 500 },
			--	screen = 1,
			--},
			{
				type = "Small", --平台的类型.[Tiny,Small,Med,Large,Comm五种]
				widthHeight = { 198, 384 }, --图片的宽/高[每种平台的图片宽高]
				nilHeight = 115, --树木高度像素,为模型无效值[图片中树木等的高度]
				position = { -20, 400 }, -- 图片在屏幕中的显示位置
				screen = 1, -- 数值每变大1,向右移动480像素(根据config.lua的配置为向右移动一个内容的宽度)
			},
			--{
			--	type = "Comm",
			--	widthHeight = { 450, 236 },
			--	nilHeight = 56,
			--	position = { 660, 400 },
			--	screen = 1,
			--},
			{
				type = "Med",
				widthHeight = { 290, 290 },
				nilHeight = 95,
				position = { 600, 500 },
				screen = 1,
			},
			{
				type = "Tiny",
				widthHeight = { 136, 106 },
				nilHeight = 16,
				position = { 1100, 500 },
				screen = 1,
			},
		},

		golds = {
			{ position = { -40, 450 }, screen = 1 },
			{ position = { 0, 450 }, screen = 1 },
			{ position = { 40, 450 }, screen = 1 },
			{ position = { 80, 450 }, screen = 1 },
			{ position = { 120, 450 }, screen = 1 },
			{ position = { 160, 450 }, screen = 1 },
			{ position = { -300, 400 }, screen = 2 },
			{ position = { -340, 400 }, screen = 2 },
			{ position = { -380, 360 }, screen = 2 },
			{ position = { -420, 400 }, screen = 2 },
			{ position = { -460, 400 }, screen = 2 },
		},

		-- 道具 提供增益状态[type:道具名称和种类]
		Props = {
			---- 红药
			--{
			--	type = "redPill",
			--	widthHeight = { 63, 67 },
			--	position = { 1100, 450 },
			--	screen = 1
			--},

			-- 蓝药
			--{
			--	type = "bluePill",
			--	widthHeight = { 63, 67 },
			--	position = { 200, 450 },
			--	screen = 1
			--},

			---- 钱袋
			{
				type = "adsorption",
				widthHeight = { 50, 54 },
				position = { 1100, 400 },
				screen = 1
			},

			-- 盾牌
			--{
			--	type = "shield",
			--	widthHeight = { 88, 115 },
			--	position = { 260, 400 },
			--	screen = 1
			--},

			--体型变大
			{
				type = "bigPill",
				widthHeight = { 50, 54 },
				position = { 400, 350 },
				screen = 1
			},

			-- 冲刺
			--{
			--	type = "star",
			--	widthHeight = { 38, 41 },
			--	position = { 350, 400 },
			--	screen = 1
			--},
		},
	}



	-------------------------------------
	---- 根据以上格式,可以再任意添加场景
	-------------------------------------
}

return M

