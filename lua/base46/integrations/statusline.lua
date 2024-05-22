local colors = require("base46").get_theme_tb("base_30")
local lighten = require("base46.colors").change_hex_lightness
-- local lighten = require("base46.colors").change_hex_lightness
local merge_tb = require("base46").merge_tb

-- change color values according to statusilne themes
-- local config = require("core.utils").load_config().ui
-- local statusline_theme = config.statusline.theme

-- if statusline_theme == "vscode" then
-- colors.statusline_bg = generate_color(colors.statusline_bg, 1)
-- colors.light_grey = generate_color(colors.light_grey, 20)
-- elseif statusline_theme == "vscode_colored" then

colors.statusline_bg = lighten(colors.statusline_bg, 1)
colors.light_grey = lighten(colors.light_grey, 15)
-- end
local statusline_theme = "default"
-- local statusline_theme = "vscode_colored"
local lsp_highlights = {
	StLineLSPError = {
		fg = colors.red,
		bg = colors.statusline_bg,
	},

	StLineLSPWarning = {
		fg = colors.yellow,
		bg = colors.statusline_bg,
	},

	StLineLSPHints = {
		fg = colors.purple,
		bg = colors.statusline_bg,
	},

	StLineLSPInfo = {
		fg = colors.green,
		bg = colors.statusline_bg,
	},
}

local M = {}

M.default = {
	StLineMain = {
		bg = colors.statusline_bg,
	},

	StLineGitIcons = {
		fg = colors.light_grey,
		bg = colors.statusline_bg,
		bold = true,
	},

	StLineLSPStatus = {
		fg = colors.nord_blue,
		bg = colors.statusline_bg,
	},

	StLineLSPProgress = {
		fg = colors.green,
		bg = colors.statusline_bg,
	},

	StLineLSPStatusIcon = {
		fg = colors.black,
		bg = colors.nord_blue,
	},

	StLineEmptySpace = {
		fg = colors.grey,
		bg = colors.lightbg,
	},

	StLineEmptySpace2 = {
		fg = colors.grey,
		bg = colors.statusline_bg,
	},

	StLineFileInfo = {
		bg = colors.one_bg,
		fg = lighten(colors.white, -20),
	},

	StLineFileSep = {
		bg = colors.statusline_bg,
		fg = colors.lightbg,
	},

	StLineCwdIcon = {
		fg = colors.one_bg,
		bg = colors.red,
	},

	StLineCwdText = {
		fg = colors.white,
		bg = colors.lightbg,
	},

	StLineCwdSep = {
		fg = colors.red,
		bg = colors.statusline_bg,
	},

	StLinePosSep = {
		fg = lighten(colors.white, -20),
		bg = colors.lightbg,
	},

	StLinePosIcon = {
		fg = colors.black,
		bg = colors.green,
	},

	StLinePosText = {
		fg = colors.green,
		bg = colors.lightbg,
	},
}

M.vscode = {
	StLineMain = {
		fg = colors.light_grey,
		bg = colors.statusline_bg,
	},

	StLineMode = {
		fg = colors.light_grey,
		bg = colors.one_bg3,
	},

	StLineText = {
		fg = colors.light_grey,
		bg = colors.statusline_bg,
	},
}

M.vscode_colored = {
	StLineMain = {
		fg = colors.light_grey,
		bg = colors.statusline_bg,
	},

	StLineText = {
		fg = colors.light_grey,
		bg = colors.statusline_bg,
	},

	-- LSP
	StLineLSPError = {
		fg = colors.red,
		bg = colors.statusline_bg,
		bold = true,
	},

	StLineLSPWarning = {
		fg = colors.yellow,
		bg = colors.statusline_bg,
		bold = true,
	},

	StLineLSPHints = {
		fg = colors.purple,
		bg = colors.statusline_bg,
		bold = true,
	},

	StLineLSPInfo = {
		fg = colors.green,
		bg = colors.statusline_bg,
		bold = true,
	},

	StLineLSPStatus = {
		fg = colors.green,
		bg = colors.statusline_bg,
	},

	StLineLSPProgress = {
		fg = colors.red,
		bg = colors.statusline_bg,
	},

	StLineCwd = {
		fg = colors.red,
		bg = colors.one_bg3,
	},

	StLineEncode = {
		fg = colors.orange,
		bg = colors.statusline_bg,
	},

	StLineFileType = {
		fg = colors.blue,
		bg = colors.statusline_bg,
	},
}

-- M.minimal = {
-- 	StLineMain = {
-- 		bg = colors.black,
-- 	},
--
-- 	StLineGitIcons = {
-- 		fg = generate_color(colors.light_grey, 8),
-- 		bg = colors.black,
-- 		bold = true,
-- 	},
--
-- 	-- LSP
-- 	StLineLSPError = {
-- 		fg = colors.red,
-- 		bg = colors.black,
-- 	},
--
-- 	StLineLSPWarning = {
-- 		fg = colors.yellow,
-- 		bg = colors.black,
-- 	},
--
-- 	StLineLSPHints = {
-- 		fg = colors.purple,
-- 		bg = colors.black,
-- 	},
--
-- 	StLineLSPInfo = {
-- 		fg = colors.green,
-- 		bg = colors.black,
-- 	},
--
-- 	StLineLSPProgress = {
-- 		fg = colors.green,
-- 		bg = colors.black,
-- 	},
--
-- 	StLineLSPStatusIcon = {
-- 		fg = colors.black,
-- 		bg = colors.nord_blue,
-- 	},
--
-- 	StLineEmptySpace = {
-- 		fg = colors.black,
-- 		bg = colors.black,
-- 	},
--
-- 	StLineEmptySpace2 = {
-- 		fg = colors.black,
-- 	},
--
-- 	StLineFileInfo = {
-- 		bg = colors.black,
-- 		fg = colors.white,
-- 	},
--
-- 	StLineFileSep = {
-- 		bg = colors.black,
-- 		fg = colors.black,
-- 	},
--
-- 	StLineSepR = {
-- 		bg = colors.black,
-- 		fg = colors.one_bg,
-- 	},
-- }

-- local hlgroups_minimal_glassy = {
-- "StLineLSPError",
-- "StLineLSPWarning",
-- "StLineLSPHints",
-- "StLineGitIcons",
-- "StLineLSPInfo",
-- "StLineEmptySpace",
-- "StLineLSPProgress",
-- "StLineSepR",
-- }

-- if Base46.opts.transparency then
-- for _, value in ipairs(hlgroups_minimal_glassy) do
-- M.minimal[value].bg = "NONE"
-- end
-- end

-- add common lsp highlights
-- M.default = merge_tb(M.default, lsp_highlights)
M.default = merge_tb(M.default, lsp_highlights, M.vscode_colored)
M.vscode_colored = merge_tb(M.vscode_colored, lsp_highlights)

local function genModes_hl(modename, col)
	M.default["StLine" .. modename .. "Mode"] =
		{ fg = colors.black, bg = colors[col], bold = true }
	M.default["StLine" .. modename .. "ModeSep"] =
		{ fg = colors[col], bg = colors.grey }

	M.vscode_colored["StLine" .. modename .. "Mode"] =
		{ fg = colors[col], bg = colors.one_bg3, bold = true }

	-- M.minimal["StLine" .. modename .. "Mode"] =
	-- { fg = colors.black, bg = colors[col], bold = true }
	-- M.minimal["StLine" .. modename .. "ModeSep"] =
	-- { fg = colors[col], bg = colors.black, bold = true }
	-- M.minimal["StLine" .. modename .. "ModeText"] =
	-- { fg = colors[col], bg = colors.one_bg, bold = true }
end

-- add mode highlights
-- if statusline_theme == "default" then
genModes_hl("Normal", "nord_blue")
-- else
-- genModes_hl("Normal", "blue")
-- end

genModes_hl("Visual", "cyan")
genModes_hl("Insert", "dark_purple")
genModes_hl("Terminal", "green")
genModes_hl("NTerminal", "yellow")
genModes_hl("Replace", "orange")
genModes_hl("Confirm", "teal")
genModes_hl("Command", "green")
genModes_hl("Select", "blue")

-- add block highlights for minimal theme
-- local function gen_hl(name, col)
-- 	M.minimal["StLine" .. name .. "Bg"] = {
-- 		fg = colors.black,
-- 		bg = colors[col],
-- 	}
--
-- 	M.minimal["StLine" .. name .. "Txt"] = {
-- 		fg = colors[col],
-- 		bg = colors.one_bg,
-- 	}
--
-- 	M.minimal["StLine" .. name .. "Sep"] = {
-- 		fg = colors[col],
-- 		bg = colors.black,
-- 	}
-- end
--
-- gen_hl("File", "red")
-- gen_hl("Pos", "yellow")
-- gen_hl("Cwd", "orange")
-- gen_hl("Lsp", "green")

return M[statusline_theme]
