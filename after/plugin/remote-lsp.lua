local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

-- local util = lspconfig.util
-- util.on_setup = util.add_hook_before(util.on_setup, function (config)
--     local o_root_dir = config.root_dir
--     config.root_dir = function(fname, bufnr)
--         -- P(fname)
--         local dir = o_root_dir(fname)
--         return "/source"
--     end
-- end)
