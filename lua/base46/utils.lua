local fn = vim.fn
local M = {}

M.save_config = function()
	-- local
	-- local chadrc = vim.fn.stdpath("config") .. "/lua/custom/" .. "chadrc.lua"
	-- local file = io.open(, "r")
	-- if file then
	-- local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
	-- local new_content = file:read("*all"):gsub(added_pattern, new)
	local config_path = require("base46").path_to_cache("/config.lua")
	local file = io.open(config_path, "w")
	if file then
		file:write("return " .. vim.inspect(Base46.config))
		file:close()
	end
end

M.load_config = function()
	local config_path = require("base46").path_to_cache("/config.lua")
	if vim.loop.fs_stat(config_path) then
		Base46.config = dofile(config_path)
	else
		Base46.config = {}
	end
end

M.list_themes = function()
	local themes = fn.readdir(fn.stdpath("config") .. "/lua/base46/themes")
	if Base46.opts.custom_themes_path ~= "" then
		local custom_themes = vim.loop.fs_stat(Base46.opts.custom_themes_path)
		if custom_themes.type == "directory" then
			custom_themes = fn.readdir(Base46.opts.custom_themes_path)
			-- local custom_themes = vim.loop.fs_stat(fn.stdpath("config") .. "/lua/custom/themes")
			-- local default_themes = {}
			-- if custom_themes and custom_themes.type == "directory" then
			-- local themes_tb = fn.readdir(fn.stdpath("config") .. "/lua/custom/themes")
			for _, value in ipairs(custom_themes) do
				themes[#themes + 1] = value
			end
		end
	end
	for index, theme in ipairs(themes) do
		themes[index] = theme:match("(.+)%..+")
	end

	return themes
end
return M
