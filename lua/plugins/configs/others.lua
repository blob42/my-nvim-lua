local M = {}

local load_override = require("core.utils").load_override

M.nvchad_ui = function()
  local present, nvchad_ui = pcall(require, "nvchad_ui")

  if present then
    nvchad_ui.setup()
  end
end

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not (present1 and present2) then
    return
  end

  local options = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  }

  options = load_override(options, "windwp/nvim-autopairs")
  autopairs.setup(options)

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.blankline = function()
  local present, blankline = pcall(require, "indent_blankline")

  if not present then
    return
  end

  require("base46").load_highlight "blankline"

  local options = {
    indentLine_enabled = 1,
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
      "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
  }

  options = load_override(options, "lukas-reineke/indent-blankline.nvim")
  blankline.setup(options)
  require("theme.highlights").blankline()
end

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")

  if not present then
    return
  end

  local options = {
    filetypes = {
      "*",
    },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      mode = "background", -- Set the display mode.
    },
  }

  options = load_override(options, "NvChad/nvim-colorizer.lua")
  colorizer.setup(options["filetypes"], options["user_default_options"])

  vim.cmd "ColorizerAttachToBuffer"
end

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")

  if not present then
    return
  end

  local options = {}
  options = load_override(options, "numToStr/Comment.nvim")
  nvim_comment.setup(options)
end


M.devicons = function()
  local present, devicons = pcall(require, "nvim-web-devicons")

  if present then
    require("base46").load_highlight "devicons"

    local options = { override = require("nvchad_ui.icons").devicons }
    options = require("core.utils").load_override(options, "kyazdani42/nvim-web-devicons")

    devicons.setup(options)
  end
end

return M
