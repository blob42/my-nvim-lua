local present, signature = pcall(require, "lsp_signature")

if not present then
  return
end

local config = {
  floating_window = true,
  hint_enable  = true,

}

M = {}
M.setup = function()
  signature.setup(config)
end

return M
