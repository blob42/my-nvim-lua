local present, todo = pcall(require, "todo-comments")

if not present then
  return
end

M = {}

local config = {
  keywords = {
    ["_TODO"] = { color = "warning"},
    ["LEARN"] = { color = "hint" },
    ["WIP"] = { color = "default"},
  },
  colors = {
    info = {"#2563EB"},
    hint = {"#10B981"},
    default = {"#8C3AED" },
  },
}

M.setup = function()
  todo.setup(config)
end


return M
