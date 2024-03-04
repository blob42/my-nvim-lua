local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function dwm()
    local group = augroup('dwm', {})
    autocmd({'BufWritePost'}, {
        group = group,
        pattern = '*/suckless/*/{*.c,*.h}',
        callback = function()
            local make_cmd = 'make && doas make install'
            -- if vim.env.STREAMING ~= nil then
            --     make_cmd = 'make && make install'
            -- end

            vim.cmd("AsyncRun " .. make_cmd)
        end
    })
end

dwm()
