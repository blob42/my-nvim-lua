M = {}
M.shown = true

-- toggle diagnostics with show/hide
M.toggle = function ()
  if M.shown  then
    M.shown = false
    return vim.diagnostic.hide()
  end
  M.shown = true
  vim.diagnostic.show()
end

-- my customized attach
-- M.custom_attach = function(client, bufnr)
-- end


return M
