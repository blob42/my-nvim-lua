local M = {}

M.base_30 = {
  white         = "#F8F8F2",
  darker_black  = "#222430",
  black         = "#282A36", --  nvim bg
  black2        = "#2d303e",
  one_bg        = "#373844", -- real bg of onedark
  one_bg2       = "#44475a",
  one_bg3       = "#565761",
  grey          = "#5e5f69",
  grey_fg       = "#666771",
  grey_fg2      = "#6e6f79",
  light_grey    = "#73747e",
  red           = "#e87c7c",
  baby_pink     = "#ef9d9d",
  pink          = "#ec8cc3",
  line          = "#3c3d49", -- for lines like vertsplit
  green         = "#7ddc95",
  vibrant_green = "#5dff88",
  nord_blue     = "#8b9bcd",
  blue          = "#a1b1e3",
  yellow        = "#8d90e2",
  sun           = "#dea946",
  purple        = "#BD93F9",
  dark_purple   = "#BD93F9",
  teal          = "#92a2d4",
  orange        = "#FFB86C",
  cyan          = "#74a9e1",
  statusline_bg = "#2d2f3b",
  lightbg       = "#41434f",
  pmenu_bg      = "#92a2d4",
  folder_bg     = "#BD93F9",
}

M.base_16 = {
  base00 = "#282936",
  base01 = "#3a3c4e",
  base02 = "#4d4f68",
  base03 = "#626483",
  base04 = "#94b2b6",
  base05 = "#e9e9f4",
  base06 = "#f1f2f8",
  base07 = "#f7f7fb",
  base08 = "#c2abd5", -- #TODO!: secondary
  base09 = "#e9b782",
  base0A = "#7dc2cd",
  base0B = "#e8cfcf",
  base0C = "#8BE9FD",
  base0D = "#ef9d9d", --  #NOTE: primmary
  base0E = "#c5c0c3",
  base0F = "#f7f7f3",
}

-- M.polish_hl = {
--   ["@function.builtin"] = { fg = M.base_30.cyan },
--   ["@number"] = { fg = M.base_30.purple },
-- }

vim.opt.bg = "dark"

M = require("base46").override_theme(M, "blob42")

return M
