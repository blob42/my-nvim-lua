---@diagnostic disable: undefined-global
--
-- TODO!: how to cleanly exec system processes (fn.execute vs os.execute vs jobstart)
-- local function gen_uuid(args, parent)
--     t = os.execute("uuidgen")
-- end

return {
    -- s("sniptest",  {
    --     t"hello snippet"
    -- })
    --

    -- choice nodes
    s("choice", fmt("{} my {}",{
        c(2, {t("hello"), t("hi")}),
        c(1, {t"bob", t"alice"})
    })
    ),

    -- function node
    s("pwd", f(function()
        return vim.fn.getcwd()
    end))
}, { --autosnippets
    -- s("uuid#", f(gen_uuid))
}

-- 
