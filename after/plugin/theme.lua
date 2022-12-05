local c = require("base46.colors")

local colors = require("base46").get_theme_tb "base_30"
-- local theme = require("base46").get_theme_tb "base_16"

local ts_context_hl = c.change_hex_saturation(colors["yellow"], -20)
local ts_context_hl = c.change_hex_lightness(ts_context_hl, -55)


local highlights = {
    TreesitterContext = {
      bg = ts_context_hl,
    },
    InlayHint = {
        fg = "#a9a19a",
    },
    Comment = {
        fg = c.change_hex_lightness(colors["one_bg"], 20),
    },
    St_file_sep_rev = {
        fg = colors.statusline_bg,
        bg = colors.lightbg,
    }
}

function set_hl()
  for hl, col in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

-- setup section
set_hl()

