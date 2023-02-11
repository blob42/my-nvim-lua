local ok, null_ls = pcall(require, 'null-ls')
if not ok then 
    vim.notify("missing module null-ls", vim.log.levels.WARN)
    return
end

_ = require('dressing')

local M = {}



M.select_sources = function()
    local sources = null_ls.get_sources()
    --TODO: add entry to disable / activate all aka disable null-ls
    vim.ui.select(sources, {
        prompt = "select source to toggle:",
        format_item = function (item)
            P(item)
            local enabled = item._disabled
            local entry = item._disabled and '' or ''

            local filetypes = ''
            for ft, _ in pairs(item.filetypes) do
                P(ft)
                filetypes = filetypes .. ft .. '|'
            end
            filetypes = filetypes:gsub('|$', '')

            entry_text = string.format("%s %-20s%s", entry, item.name, filetypes)
            -- return entry .. ' ' .. item.name .. '\t\t' .. filetypes
            return entry_text
        end,
    }, function(item)
         if item then null_ls.toggle({name = item.name }) end
    end)
end


return M
