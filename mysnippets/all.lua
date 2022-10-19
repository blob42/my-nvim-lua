---@diagnostic disable: undefined-global

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
}
