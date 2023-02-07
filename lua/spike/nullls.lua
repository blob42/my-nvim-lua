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
            local enabled = item._disabled
            local entry = item._disabled and '' or ''

            return entry .. ' ' .. item.name
        end,
    }, function(item)
         if item then null_ls.toggle({name = item.name }) end
    end)
end


return M
