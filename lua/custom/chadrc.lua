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
    ["NvChad/ui"] = {
      -- tabufline = {
      --   lazyload = false,
      -- },
      statusline = {
        overriden_modules = function()
          return require "custom.plugins.nvchadui"
        end
      }


    },
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = {
        "lua",
        "go",
        "rust",
        "fish",
        "bash",
        "python",
        "c",
        "haskell",
        "javascript",
        "html",
        "markdown",
        "markdown_inline",
        "make",
        "sql",
        "yaml",
        "toml",
        "vue",
      }
    },
  }
}

return M
