---@diagnostic disable: undefined-global

return {

        s("testluasnip", {
            t"Hello lua snippet"
        }),

        s({ trig = "lm", dscr = "local lua module"},
            fmt([[
local M = {{}}

{}

return M
            ]], { i(0) })
        ),

        -- repeat nodes
        -- TODO: split dot and pull last name
        s("req", fmt("local {} = require('{}')", {
            i(1, "default"),
            rep(1)
        })  ),

        s("ifreq", fmt([[
    local ok, {} = pcall(require, "{}")
    if not ok then 
        vim.notify("missing module {}", vim.log.levels.WARN)
        return
    end
    {}
        ]], {
            i(1),
            rep(1),
            rep(1),
            i(0)
        })

        ),

}
