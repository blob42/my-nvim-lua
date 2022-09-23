local present, todo = pcall(require, "todo-comments")

if not present then
  return
end

M = {}

local config = {
}

M.setup = function()
  todo.setup(config)
end


return M
