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

M.reload_theme = function()
  require("plenary.reload").reload_module("base46")
  require("plenary.reload").reload_module("custom.chadrc")
  require("base46").load_theme()
end

 M.set_plugin_mappings = function(plugin_name, mapping_opt)
   mappings = require("core.utils").load_config().mappings[plugin_name]
   mappings.plugin = nil

  for mode, mode_values in pairs(mappings) do
    local default_opts = vim.tbl_deep_extend("force", { mode = mode }, mapping_opt or {})
    for keybind, mapping_info in pairs(mode_values) do
      -- merge default + user opts
      local opts = vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})

      mapping_info.opts, opts.mode = nil, nil
      opts.desc = mapping_info[2]

      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end

-- convert timestamp under cursor in milliseconds to a human readable string
-- @param timestamp in milliseconds
-- @return human readable string
M.human_timestamp = function()
    cword = vim.fn.expand('<cword>')


    -- make sure cword is a number
    local n = tonumber(cword)
    if n == nil then return end

    local time = os.date("*t", cword / (1000*1000))
    format = string.format("%04d-%02d-%02d %02d:%02d:%02d", time.year, time.month, time.day, time.hour, time.min, time.sec)
    vim.notify(format, vim.lsp.log_levels.INFO)
end

-- 1663878015759000
-- 1670185951498000
-- M.human_timestamp()

return M


