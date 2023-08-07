local present, todo = pcall(require, "todo-comments")

if not present then
  return
end

local M = {}

local config = {
  keywords = {
    ["_TODO"] = {
        color = "warning",
        alt = {"TODO!"}, -- a set of other keywords that all map to this FIX keywords
    },
    LEARN  = { color = "hint" },
    WIP = { color = "default"},
    NOTE = { alt = { "TIP", "INFO", "TRICK", "RELEASE"}},
    DEBUG = {},
    REVIEW = { color = "info" }
  },
  colors = {
    -- info = {"#2563EB"},
     info = {"#dddddd"},
    hint = {"#10B981"},
    default = {"#8C3AED" },
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
