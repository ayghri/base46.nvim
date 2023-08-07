local colors = require("base46").get_theme_tb "base_30"

local M = {
  ChdChHeading = {
    fg = colors.black,
    bg = colors.blue,
    bold = true,
  },

  ChdChSection = {
    bg = colors.black2,
  },

  ChdChAsciiHeader = {
    fg = colors.blue,
    bg = colors.black2,
  },
}

local cheatsheet_theme = Base46.opts.cheatsheet_theme

if cheatsheet_theme == "grid" then
  M.ChdChAsciiHeader = {
    fg = colors.blue,
  }

  local bgcols =
    { "blue", "red", "green", "yellow", "orange", "baby_pink", "purple", "white", "cyan", "vibrant_green", "teal" }

  for _, value in ipairs(bgcols) do
    M["ChdChHead" .. value] = {
      fg = colors.black,
      bg = colors[value],
    }
  end
end

return M
