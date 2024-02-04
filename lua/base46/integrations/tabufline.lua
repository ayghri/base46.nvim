local colors = require("base46").get_theme_tb("base_30")
local lighten = require("base46.colors").change_hex_lightness

local M = {

	TbfLineFill = {
		-- bg = colors.black,
		-- bg = colors.black2,
	},

	TbfLineBufOn = {
		fg = colors.white,
		sp = colors.blue,
		bg = colors.grey_fg2,
	},

	TbfLineBufOff = {
		fg = colors.light_grey,
		bg = colors.black,
	},

	TbfLineBufOnClose = {
		fg = colors.red,
		bg = colors.black,
	},

	TbfLineBufOffClose = {
		fg = colors.light_grey,
		bg = colors.black2,
	},

	TbfLineTabNewBtn = {
		fg = colors.white,
		bg = colors.one_bg3,
		bold = true,
	},

	TbfLineTabOn = {
		fg = colors.black,
		bg = colors.nord_blue,
		bold = true,
	},

	TbfLineTabOff = {
		fg = colors.white,
		bg = colors.one_bg2,
	},

	TbfLineTabCloseBtn = {
		fg = colors.black,
		bg = colors.nord_blue,
	},

	TbfLineTabTitle = {
		fg = colors.black,
		bg = colors.white,
	},

	TbfLineThemeToggleBtn = {
		bold = true,
		fg = colors.white,
		bg = colors.one_bg3,
	},

	TbfLineCloseAllBufsBtn = {
		bold = true,
		bg = colors.red,
		fg = colors.black,
	},
}

M = vim.tbl_deep_extend("force", M, {
	TbfLineBufOnEdge = {
		fg = M.TbfLineBufOn.bg,
	},
	TbfLineBufOnModified = vim.tbl_deep_extend("force", M.TbfLineBufOn, {
		fg = colors.red,
	}),

	TbfLineBufOffModified = vim.tbl_deep_extend("force", M.TbfLineBufOff, {
		fg = lighten(colors.blue,-20),
	}),
})

return M
