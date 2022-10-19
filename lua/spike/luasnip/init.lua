local ok, ls = pcall(require, "luasnip")
if not ok then return end

-- luasnip helpers

local M = {}

---shortcut for ls.add_snippet(ft, {defs})
---@param args table arguments in the form {ft, snippet_defs}
M.add_snippet = function(args)
    for ft,sn_defs in pairs(args) do
        ls.add_snippets(ft, sn_defs, {override_priority=2000})
    end
end


return M
