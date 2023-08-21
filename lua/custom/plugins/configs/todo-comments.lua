local present, todo = pcall(require, "todo-comments")

if not present then
  return
end

local colors = require("custom.themes.blob42").base_30

local M = {}

local config = {
  keywords = {
    TODO = { icon = "✓"},
    ["_TODO"] = {
        color = "warning",
        alt = {"TODO!"}, -- a set of other keywords that all map to this FIX keywords
    },
    LEARN  = { color = "hint" },
    WIP = { color = "default", alt = {"REFACT"}},
    NOTE = { alt = { "TIP", "INFO", "TRICK", "RELEASE"}},
    DEBUG = { alt = { "DBG", }, color = "debug" },
    REVIEW = { color = "info" }
  },
  colors = {
      hint = {colors.green},
      info = {colors.blue},
      default = {colors.nord_blue},
      warning = {colors.orange},
      error =  { colors.red },
      debug = { colors.purple }
  },
  highlight = {
      -- multiline = false,
      after = "",
  }
}

M.setup = function()
  todo.setup(config)
end


return M
