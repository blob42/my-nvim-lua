local present, todo = pcall(require, "todo-comments")

if not present then
  return
end

M = {}

local config = {
  keywords = {
    ["_TODO"] = {
        color = "warning",
        alt = {"TODO!"}, -- a set of other keywords that all map to this FIX keywords
    },
    LEARN  = { color = "hint" },
    WIP = { color = "default"},
    NOTE = { alt = { "TIP", "INFO", "TRICK" }},
    DEBUG = {}
  },
  colors = {
    info = {"#2563EB"},
    hint = {"#10B981"},
    default = {"#8C3AED" },
  },
  highlight = {
      after = "fg",
  }
}

M.setup = function()
  todo.setup(config)
end


return M
