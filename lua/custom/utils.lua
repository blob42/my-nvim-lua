local M = {}

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

      P(keybind)
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end


return M
