
# Neovim base46, alpha version

This is a rewrite based on [NvChad ui](https://github.com/NvChad/ui). This is
more suitable for educational purposes to understand Neovim API and how plugins
work.


## Installation

- Lazy.nvim

```lua
 { "aghriss/base46.nvim",
  priority = 1000,
  lazy = false,
  opts = require("aghriss.plugins.options.base46"),
  config = function(_, opts)
   require("base46").setup(opts)
   require("base46").load_all_highlights()
  end,
 }

```

## Defaults

```lua
{
  theme1 = "ayu_dark",
  theme2 = "ayu_light",
  theme1_icon = "",
  theme2_icon = "",

  -- ~/.config/nvim/lua/custom/
  custom_themes_path = vim.fn.stdpath("config") .. "/lua/custom",

  -- ~/.local/state/nvim/base46/
  cache_path = vim.fn.stdpath("state") .. "/base46/",
  telescope_style = "borderless",
  cheatsheet_theme = "grid",
  transparency = false,
  -- highlights to add
  hl_add = {},

  cmp = {
   icons = true,
   lspkind_text = true,
   style = "default", -- default/flat_light/flat_dark/atom/atom_colored
   border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
   selected_item_bg = "colored", -- colored / simple
  },
 },
}
```
