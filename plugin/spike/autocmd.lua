local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function dwm()
    local group = augroup('dwm', {})
    autocmd({'BufWritePost'}, {
        group = group,
        pattern = '*/suckless/*/{*.c,*.h}',
        callback = function()
            local make_cmd = 'make && make install'
            -- if vim.env.STREAMING ~= nil then
            --     make_cmd = 'make && make install'
            -- end

            vim.cmd("AsyncRun " .. make_cmd)
        end
    })
end

local function xremap()
    local group = augroup('xremap', {})
    autocmd({'BufWritePost'}, {
        group = group,
        pattern = '*/.config/xremap/*.yml',
        callback = function()
            vim.system({"systemctl", "--user", "restart", "xremap"}):wait()
        end
    })
end

dwm()
xremap()
