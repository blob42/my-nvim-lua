M = {}
M.shown = true

-- toggle diagnostics with show/hide
M.toggle_diagnostics = function ()
  if M.shown  then
    M.shown = false
    return vim.diagnostic.hide()
  end
  vim.diagnostic.show()
  M.shown = true
end

-- my customized attach
-- M.custom_attach = function(client, bufnr)
-- end


return M
