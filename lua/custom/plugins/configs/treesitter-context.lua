local ok, tscontext = pcall(require,"treesitter-context")
if not ok then return end

local M = {}

local config = {
  enable = true
}

M.config = config

function M.setup()
  tscontext.setup(config)
end

return M



