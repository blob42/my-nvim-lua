-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "monekai",
  theme_toggle = { "monekai", "blossom" },
  hl_override = {
    DiagnosticWarn = {
      fg = "yellow",
      italic = true,
    },
    St_LspWarning = {
      fg = "yello"
    },
    DiagnosticHint = {
      fg = "purple",
      italic = true,
    },
    St_LspHints = {
      fg = "pruple",
    },
    DiagnosticError = {
      italic = true,
    },
    St_LspInfo = {
      fg = "teal"
    },
  },
  hl_add = {
    DiagnosticInfo = { -- nvchad uses DiagnosticInformation wrong hi group for lsp
      fg = "teal",
      italic = true,
    },
    DiagnosticFloatingInfo = {
      fg="white",
      italic=true,
    },
    -- Code Lens related colors
     LspCodeLens = {
      fg = "vibrant_green",
      underline = true,
    },
    LspDiagnosticsSignHint = { -- LspDiagnostics Code Action
      fg = "vibrant_green",
      italic = true,
    },
    -- end of code lens colors
    DiffText = {
      bg = "vigrant_green"
    }
  },
  -- hl_override = {
  --   CursorLine = {
  --     underline = 1
  --   }
  -- },
  myicons = {
    lsp = {
      diagnostic_head = '',   -- default diagnostic head on dialogs
      diagnostic_err =  '',    -- severity 1
      diagnostic_warn = '',   --          2
      diagnostic_info = '',   --          3
      diagnostic_hint = '',   --          4
    }
  },
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
