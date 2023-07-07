local ok, null_ls = pcall(require, 'null-ls')
if not ok then 
    vim.notify("missing module null-ls", vim.log.levels.WARN)
    return
end

_ = require('dressing')

local M = {}

M.register_sources = function()
    local sources = require('custom.plugins.configs.null-ls').extra_sources
    vim.ui.select(sources, {
        prompt = "select source to register:",
        format_item = function (item)
            local enabled = null_ls.is_registered({ name = item.name})
            local entry = enabled and '' or ''
            local filetypes = ''
            for _, ft in ipairs(item.filetypes) do
                filetypes = filetypes .. ft .. '|'
            end
            filetypes = filetypes:gsub('|$', '')

            local entry_text = string.format("%s %-20s%s", entry, item.name, filetypes)
            -- return entry .. ' ' .. item.name .. '\t\t' .. filetypes
            return entry_text
        end,
    }, function(item)
         if item then null_ls.register(item) end
    end)
end

M.select_sources = function()
    local sources = null_ls.get_sources()
    --
    --TODO: add entry to disable / activate all aka disable null-ls
    vim.ui.select(sources, {
        prompt = "select source to toggle:",
        format_item = function (item)
            local entry = item._disabled and '' or ''

            local filetypes = ''
            for ft, _ in pairs(item.filetypes) do
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
