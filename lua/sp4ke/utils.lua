local M = {}
M["unload_lua_ns"] = function (prefix)
  local prefix_with_dot = prefix .. '.'
  for key, _ in pairs(package.loaded) do
    if key == prefix or key:sub(1, #prefix_with_dot) == prefix_with_dot then
      print("removing: ", key)
      package.loaded[key] = nil
    end
  end
end

-- M.unload_lua_ns("core")
M.list_loaded_modules = function ()
  local loaded = {}
  for k, _ in pairs(package.loaded) do
    loaded[#loaded + 1] = k
  end
  vim.ui.select(loaded, {}, nil)

end

return M
