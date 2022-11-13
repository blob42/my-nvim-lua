-- custom golang lsp settings

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local M = {}

local augroupname = "spike.go"

-- Navigator custom on_attach for golang
  
function  M.gopls_onattach(client, bufnr)
  -- auto auto format on save
  local ok, goformat = pcall(require, "go.format")
  if not ok then
    print("go.nvim missing !")
    return
  end


  -- Auto import on save
  -- autocmd({"BufWritePre", "InsertLeave"}, {
  -- autocmd({"BufWritePre"}, {
  --   group = augroup(augroupname, {clear = true}),
  --   buffer = bufnr,
  --   callback = function()
  --     goformat.goimport()
  --   end
  -- })

  require("core.utils").load_mappings "golang"
    
end

return M
