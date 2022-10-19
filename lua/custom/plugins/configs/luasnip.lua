local present, luasnip = pcall(require, "luasnip")

if not present then
    return
end

local types = require("luasnip.util.types")

local options = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            passive = {
                virt_text = { { " ", "LuaSnipChoice" } },
            }
        },
        [types.insertNode] = {
            passive = {
                virt_text = { { " ", "LuaSnipInsert" } },
            }
        }
    },
}

M.setup = function()
    luasnip.config.set_config(options)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }

    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
            then
                require("luasnip").unlink_current()
            end
        end,
    })
end

return M
