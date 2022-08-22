-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "monekai",
  theme_toggle = { "monekai", "blossom" },
  -- hl_override = {
  --   CursorLine = {
  --     underline = 1
  --   }
  -- },
}

M.plugins = {
  user = require "custom.plugins",
  override = {
    ["nvim-treesitter/nvim-treesitter"] = {
    }
  }
}

return M
