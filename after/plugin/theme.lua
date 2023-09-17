--TODO: migrate to noirbuddy
-- used to override nvchad highlights
local c = require("base46.colors")

local colors = require("base46").get_theme_tb "base_30"
local colors16 = require("base46").get_theme_tb "base_16"
-- local theme = require("base46").get_theme_tb "base_16"

local ts_context_hl = c.change_hex_saturation(colors["yellow"], -20)
local ts_context_hl = c.change_hex_lightness(ts_context_hl, -55)

local highlights = {
    -- TreesitterContext = {
    --   bg = ts_context_hl,
    -- },
    -- InlayHint = {
    --     fg = "#a9a19a",
    -- },
    -- Comment = {
    --     fg = c.change_hex_lightness(colors["one_bg"], 20),
    -- },
    St_file_sep_rev = {
        fg = colors.statusline_bg,
        bg = colors.lightbg,
    },
    -- DiagnosticUnderlineError = {
    --     fg = c.change_hex_lightness(colors["red"], 5),
    --     underline = true,
    -- },

}

local statusline = {

  StatusLine = {
    bg = colors.statusline_bg,
  },

  St_gitIcons = {
    fg = colors.light_grey,
    bg = colors.statusline_bg,
    bold = true,
  },

  -- LSP

  St_lspError = {
    fg = colors.red,
    bg = colors.statusline_bg,
  },

  St_lspWarning = {
    fg = colors.yellow,
    bg = colors.statusline_bg,
  },

  St_LspHints = {
    fg = colors.purple,
    bg = colors.statusline_bg,
  },

  St_LspInfo = {
    fg = colors.green,
    bg = colors.statusline_bg,
  },

  St_LspStatus = {
    fg = colors.nord_blue,
    bg = colors.statusline_bg,
  },

  St_LspProgress = {
    fg = colors.green,
    bg = colors.statusline_bg,
  },

  St_LspStatus_Icon = {
    fg = colors.black,
    bg = colors.nord_blue,
  },

  -- MODES

  St_NormalMode = {
    fg = colors.blue,
    bg = colors.black,
  },

  St_InsertMode = {
    fg = colors16.base0B,
    bg = colors.black,

  },

  St_TerminalMode = {
    fg = colors.green,
    bg = colors.black,
  },

  St_NTerminalMode = {
    fg = colors.yellow,
    bg = colors.black,
  },

  St_VisualMode = {
    fg = colors.cyan,
    bg = colors.black,
  },

  St_ReplaceMode = {
    fg = colors.orange,
    bg = colors.black,
  },

  St_ConfirmMode = {
    fg = colors.teal,
    bg = colors.black,
  },

  St_CommandMode = {
    fg = colors.green,
    bg = colors.black,
  },

  St_SelectMode = {
    fg = colors.nord_blue,
    bg = colors.black,
  },

  -- Separators for mode
  St_NormalModeSep = {
    bg = colors.nord_blue,
    fg = colors.black,
  },

  St_InsertModeSep = {
    bg = colors16.base0B,
    fg = colors.black,
  },

  St_TerminalModeSep = {
    bg = colors.green,
    fg = colors.black,
  },

  St_NTerminalModeSep = {
    bg = colors.yellow,
    fg = colors.black,
  },

  St_VisualModeSep = {
    bg = colors.cyan,
    fg = colors.black,
  },

  St_ReplaceModeSep = {
    bg = colors.orange,
    fg = colors.black,
  },

  St_ConfirmModeSep = {
    bg = colors.teal,
    fg = colors.black,
  },

  St_CommandModeSep = {
    bg = colors.green,
    fg = colors.black,
  },

  St_SelectModeSep = {
    bg = colors.nord_blue,
    fg = colors.black,
  },

  St_EmptySpace = {
    fg = colors.grey,
    bg = colors.lightbg,
  },

  St_EmptySpace2 = {
    fg = colors.grey,
    bg = colors.statusline_bg,
  },

  St_file_info = {
    bg = colors.black,
    fg = colors.grey_fg2,
  },

  St_file_sep = {
    bg = colors.statusline_bg,
    fg = colors.black,
  },

  St_cwd_icon = {
    fg = colors.one_bg,
    bg = colors.red,
  },

  St_cwd_text = {
    fg = colors.grey_fg2,
    bg = colors.black,
  },

  St_cwd_sep = {
    fg = colors.red,
    bg = colors.statusline_bg,
  },

  St_pos_sep = {
    fg = colors.base04,
    bg = colors.lightbg,
  },

  St_pos_icon = {
    fg = colors.black,
    bg = colors.green,
  },

  St_pos_text = {
    fg = colors16.base04,
    bg = colors.lightbg,
  },
}

function set_hl()
  for hl, col in pairs(vim.tbl_deep_extend("force", highlights, statusline)) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

-- setup section
set_hl()

