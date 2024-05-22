local colors = require("base46").get_theme_tb("base_30")
local theme = require("base46").get_theme_tb("base_16")

return {
  -- `@annotation` is not one of the default capture group, should we keep it
  ["@annotation"] = {
    fg = theme.base0F,
  },

  ["@attribute"] = {
    fg = theme.base0A,
  },

  ["@identifier"] = {
    fg = colors.purple,
  },
  ["@character"] = {
    fg = theme.base08,
  },
  -- braces {},
  ["@constructor"] = {
    fg = theme.base08,
  },

  ["@constant"] = {
    fg = theme.base08,
  },

  ["@constant.builtin"] = {
    fg = theme.base09,
  },

  ["@constant.macro"] = {
    fg = theme.base08,
  },

  ["@error"] = {
    fg = theme.base08,
  },

  ["@exception"] = {
    fg = theme.base08,
  },

  ["@float"] = {
    fg = theme.base09,
  },

  ["@keyword"] = {
    -- fg = theme.base0E,
    fg = theme.base0D,
  },

  ["@keyword.function"] = {
    fg = theme.base0E,
  },

  ["@keyword.return"] = {
    fg = theme.base0E,
  },

  ["@function"] = {
    fg = theme.base0D,
  },

  ["@function.builtin"] = {
    fg = theme.base0D,
  },

  ["@function.macro"] = {
    fg = theme.base0A,
  },

  ["@function.call"] = {
    -- fg = theme.base0D,
    fg = theme.base0A,
  },

  ["@markup.environment"] = {
    fg = colors.red,
  },
  ["@markup.environment.name"] = {
    fg = colors.green,
  },

  ["@markup.heading"] = {
    fg = theme.base0E,
  },

  ["@markup.heading.1"] = {
    fg = colors.red,
  },

  ["@markup.heading.3"] = {
    fg = colors.pink,
  },

  ["@markup.heading.4"] = {
    fg = theme.base0F,
  },
  ["@formula"] = {
    fg = colors.vibrant_green,
  },

  ["@module"] = {
    fg = colors.nord_blue,
  },

  ["@markup.link.label"] = {
    fg = theme.base0C,
  },
  ["@markup.link.url"] = {
    fg = theme.base09,
  },

  ["@markup.list"] = {
    fg = colors.red,
    bold = true,
  },

  ["@operator"] = {
    fg = theme.base05,
  },

  ["@keyword.operator"] = {
    fg = theme.base0E,
  },

  ["@method"] = {
    -- fg = theme.base0D,
    fg = theme.base0A,
  },

  ["@method.call"] = {
    -- fg = theme.base0D,
    fg = theme.base0A,
  },

  ["@namespace"] = {
    fg = theme.base08,
  },

  ["@none"] = {
    fg = theme.base07,
  },

  ["@parameter"] = {
    fg = theme.base08,
  },

  ["@reference"] = {
    fg = theme.base05,
  },

  ["@punctuation.bracket"] = {
    fg = theme.base0F,
  },

  ["@punctuation.delimiter"] = {
    fg = theme.base0F,
  },

  ["@punctuation.special"] = {
    fg = theme.base0A,
  },

  ["@string"] = {
    fg = theme.base0B,
  },
  -- ?
  ["@string.regex"] = {
    fg = theme.base0C,
  },

  ["@string.escape"] = {
    fg = theme.base0C,
  },

  ["@string.special"] = {
    fg = theme.base0C,
  },

  ["@symbol"] = {
    fg = theme.base0B,
  },

  ["@tag"] = {
    link = "Tag",
  },

  ["@tag.attribute"] = {
    link = "@property",
  },

  ["@tag.delimiter"] = {
    fg = theme.base0F,
  },

  ["@text"] = {
    fg = theme.base08,
  },

  ["@text.strong"] = {
    bold = true,
  },

  ["@text.emphasis"] = {
    fg = theme.base09,
  },

  ["@text.strike"] = {
    fg = theme.base0F,
    strikethrough = true,
  },

  ["@text.literal"] = {
    fg = theme.base09,
  },

  ["@text.uri"] = {
    fg = theme.base09,
    underline = true,
  },

  ["@type.builtin"] = {
    fg = theme.base0A,
  },

  ["@variable"] = {
    fg = theme.base05,
  },

  ["@variable.builtin"] = {
    fg = theme.base09,
  },

  -- variable.global

  ["@definition"] = {
    sp = theme.base04,
    underline = true,
  },

  -- TSDefinitionUsage = {
  --   sp = theme.base04,
  --   underline = true,
  -- },

  ["@scope"] = {
    bold = true,
  },

  ["@field"] = {
    fg = theme.base08,
  },

  ["@field.key"] = {
    fg = theme.base08,
  },

  ["@property"] = {
    fg = theme.base08,
  },

  ["@include"] = {
    link = "Include",
  },

  ["@conditional"] = {
    link = "Conditional",
  },
}
