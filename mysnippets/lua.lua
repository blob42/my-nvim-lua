---@diagnostic disable: undefined-global

-- return two lists of snippets: first are normal snippets second are autosnippets
return {
        s({ trig = "lm", dscr = "local lua module"},
            fmt([[
local M = {{}}

{}

return M
            ]], { i(0) })
        ),

        -- repeat nodes
        -- TODO: split dot and pull last name
        -- local require
        s("lreq", fmt("local {} = require('{}')", {
            i(1, "default"),
            rep(1)
        })  ),

        -- if require
        s("ifreq", fmt([[
    local ok, {} = pcall(require, '{}')
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

        -- add packer plugin
        s({ trig = "plug", dscr = "add packer plugin"}, fmt([[
        ["{}"] = {{
            config = function()
                require("custom.plugins.configs.{}").{}
            end,
        }},
        ]], {
            i(1),
            i(2),
            i(0)
        }))

}, { -- autosnippets
    -- s("autotrig", t("autotriggered"))
}


