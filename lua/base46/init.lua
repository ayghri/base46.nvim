-- hl: highlight
-- tb: table
-- th: theme
-- local config = require("core.utils").load_config()
-- TODO: what it is?, I know it's the base46 source code path
-- local base46_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

local config = require("base46.config")
local M = {}

M.merge_tb = function(...) return vim.tbl_deep_extend("force", ...) end

M.join_paths = function(paths_tb)
	return vim.fs.normalize(table.concat(paths_tb, "/"))
end

M.path_to_cache = function(...)
	local args = { Base46.opts.cache_path, ... }
	return M.join_paths(args)
end

M.get_theme_tb = function(type)
	if not Base46.config.theme then
		-- P(Base46)
		error("Theme is not set")
	end
	local default_p = "base46.themes." .. Base46.config.theme
	local custom_p = M.join_paths({
		Base46.opts.custom_themes_path,
		Base46.config.theme .. ".lua",
	})

	local default_valid, default_th = pcall(require, default_p)
	local custom_valid, custom_th = pcall(dofile, custom_p)
	-- local _, user_theme = pcall(require, user_path)

	if default_valid then
		return default_th[type]
	elseif custom_valid then
		return custom_th[type]
	else
		error("No such theme!")
	end
end

-- turns color var names in hl_override/hl_add to actual colors
-- hl_add = { abc = { bg = "one_bg" }} -> bg = colors.one_bg
M.turn_str_to_color = function(tb)
	local colors = M.get_theme_tb("base_30")
	local copy = vim.deepcopy(tb)

	for _, hlgroups in pairs(copy) do
		for opt, val in pairs(hlgroups) do
			if
				(opt == "fg" or opt == "bg" or opt == "sp")
				and not (val:sub(1, 1) == "#" or val == "none" or val == "NONE")
			then
				hlgroups[opt] = colors[val]
			end
		end
	end
	return copy
end

M.extend_default_hl = function(highlights)
	-- extend highlights from polish_hl and base46.glassy
	local polish_hl = M.get_theme_tb("polish_hl")
	-- polish themes
	if polish_hl then
		for key, value in pairs(polish_hl) do
			if highlights[key] then
				highlights[key] = M.merge_tb(highlights[key], value)
			end
		end
	end

	-- transparency
	-- if transparency, set bg to None for some elements defined in base46.glassy
	if Base46.opts.transparency then
		local glassy = require("base46.glassy")

		for key, value in pairs(glassy) do
			if highlights[key] then
				highlights[key] = M.merge_tb(highlights[key], value)
			end
		end
	end
	-- overide some colors from our options table
	if Base46.opts.hl_override then
		local overriden_hl = M.turn_str_to_color(Base46.opts.hl_override)

		for key, value in pairs(overriden_hl) do
			if highlights[key] then
				highlights[key] = M.merge_tb(highlights[key], value)
			end
		end
	end
end

M.get_hl_tb = function(group)
	local hl_tb = require("base46.integrations." .. group)
	-- if not hl_tb then
	-- error("cannot get hl for " .. group)
	-- print("cannot get hl for " .. group)
	-- print(vim.inspect(hl_tb))
	-- end
	M.extend_default_hl(hl_tb)
	return hl_tb
end

-- convert table into string
M.hl_to_lua = function(tb)
	-- tb in in format tb = { hl_name = {fg = ? , bg = ?, optk = optv}}
	local result = ""
	local opts = ""
	local line = ""
	for hl_group, hl_vals in pairs(tb) do
		-- local hlname = "'" .. hl_group .. "',"
		-- local opts = ""
		-- for opt_k, opt_v in pairs(hl_vals) do
		-- local valueInStr = ((type(opt_v)) == "boolean" or type(opt_v) == "number") and tostring(opt_v)
		-- or '"' .. opt_v .. '"'
		-- opts = opts .. opt_k .. "=" .. valueInStr .. ","
		-- end
		opts = vim.inspect(hl_vals, { newline = "", indent = "" })
		line = "vim.api.nvim_set_hl(0,'" .. hl_group .. "'," .. opts .. ")"

		result = result .. line .. "\n"
	end

	return result
end

M.save_hl_lua = function(filename, tb)
	local bg_opt = "vim.opt.bg='" .. M.get_theme_tb("type") .. "'"
	local defaults_cond = filename == "defaults" and bg_opt or ""
	-- lines contain the binary representation of a function that sets nvim_set_hl
	local lines = "return string.dump(function()\n"
		.. defaults_cond
		.. M.hl_to_lua(tb)
		.. "end, true)"
	local file = io.open(M.path_to_cache("compiled/", filename), "wb")

	if file then
		file:write(load(lines)())
		file:close()
	end
end

M.compile = function()
	-- P(file)
	local base46_path =
		vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
	-- All integration modules, each file returns a table
	local hls_path = M.join_paths({ base46_path, "integrations" })

	for _, file in ipairs(vim.fn.readdir(hls_path)) do
		-- skip caching some files
		if file ~= "statusline" or file ~= "treesitter" then
			local filename = vim.fn.fnamemodify(file, ":r")
			M.save_hl_lua(filename, M.get_hl_tb(filename))
		end
	end

	-- look for custom cached highlight files
	local extended_integrations = Base46.opts.extended_integrations

	if extended_integrations then
		for _, integration in ipairs(extended_integrations) do
			M.save_hl_lua(
				integration,
				require("base46.extended_integrations." .. integration)
			)
		end
	end
end

function M.load_highlights(file)
	local compiled_file = M.path_to_cache("compiled/", file)
	if not vim.loop.fs_stat(compiled_file) then
		print("Cannot find", compiled_file)
	else
		dofile(compiled_file)
	end
	-- dofile()
end

M.load_all_highlights = function()
	-- require("plenary.reload").reload_module("base46")
	M.compile()

	for _, file in ipairs(vim.fn.readdir(M.path_to_cache("compiled/"))) do
		M.load_highlights(file)
	end
end

M.override_theme = function(default_theme, theme_name)
	local changed_themes = Base46.ui.changed_themes
	return M.merge_tb(
		default_theme,
		changed_themes.all or {},
		changed_themes[theme_name] or {}
	)
end

M.toggle_theme = function()
	if Base46.config.theme == Base46.opts.theme1 then
		Base46.config.theme = Base46.opts.theme2
		Base46.config.toggle_icon = Base46.opts.theme2_icon
	else
		Base46.config.theme = Base46.opts.theme1
		Base46.config.toggle_icon = Base46.opts.theme1_icon
	end
	require("base46.utils").save_config()
	M.load_all_highlights()
end

M.toggle_transparency = function()
	Base46.config.transparency = not Base46.config.transparency
	M.load_all_highlights()
	require("base46.utils").save_config()
end

-- closes all bufs except current one
function M.setup(opts)
	Base46.opts = M.merge_tb(config.defaults, opts or Base46.opts)
	-- Create cache folder is non existent
	local changed = false
	local to_compile = false
	if not vim.loop.fs_stat(Base46.opts.cache_path) then
		vim.fn.mkdir(Base46.opts.cache_path, "p")
	end
	-- create cache_path/compiled if non existent
	local compile_path = M.path_to_cache("compiled/")
	if not vim.loop.fs_stat(compile_path) then
		to_compile = true
		vim.fn.mkdir(compile_path, "p")
	end
	-- load saved config (chosen theme)
	require("base46.utils").load_config()
	if not Base46.config.theme then
		-- if saved config does not contains a theme choice, use theme 1
		-- P("settings theme1 to config")
		Base46.config.theme = Base46.opts.theme1
		-- save the choice
		changed = true
	end
	if not Base46.config.transparency then
		-- P("settings transparency to config")
		Base46.config.transparency = Base46.opts.transparency
		changed = true
	end
	if changed then require("base46.utils").save_config() end
	if to_compile then M.compile() end
	vim.g.base46_is_setup = true
end
return M
