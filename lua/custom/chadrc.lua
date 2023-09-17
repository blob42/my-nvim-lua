-- Just an example, supposed to be placed in /lua/custom/

local M = {}

local colors = {
    neon = "#3ece8d",
    flashred = "#ff4848",
}

local highlights = require "custom.highlights"

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
--
-- local custom_theme = require("spike.theme")
-- vim.tbl_deep_extend("force", M.ui.hl_add, custom_theme)

M.ui = {
    -- theme = "gruvbox_material",
    -- theme = "ayu-dark",
    theme = "blob42",
    theme_toggle = { "blob42", "chadracula"},
    -- transparency = true,
    hl_override = highlights.override,
    hl_add = highlights.add,
    -- hl_override = {
    --   CursorLine = {
    --     underline = 1
    --   }
    -- },
    myicons = {
        lsp = {
            diagnostic_head = '', -- default diagnostic head on dialogs
            diagnostic_err = '',  -- severity 1
            diagnostic_warn = '', --          2
            diagnostic_info = '', --          3
            diagnostic_hint = '', --          4
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
                separator_style = 'block',
                overriden_modules = function()
                    return require "custom.plugins.nvchadui"
                end
            },
            tabufline = {
                enabled = false,
            }
        },
        ["windwp/nvim-autopairs"] = {
            disable_filetype = {
                "TelescopePrompt",
                "vim",
                "guihua",
                "guihua_rust",
                "clap_input",
                "markdown"
            }
        },
        ["nvim-treesitter/nvim-treesitter"] = require "custom.plugins.configs.treesitter",
    }
}

return M
