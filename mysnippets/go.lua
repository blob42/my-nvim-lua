---@diagnostic disable: unused-local, undefined-global

return {
    -- s("testgo", {
    --     t"Hello go snippet"
    -- })

    -- defer
    s("def", fmt([[ 
    defer func(){{
        {}
    }}()

    ]],
    {
        i(0)
    })

    ),

    -- defer and handle error from some call
    s({trig = "defe", dscr = "defer with error"}, fmt([[ 
    defer func(){{
        err := {}
        if err != nil {{
            {}
        }}
    }}()

    ]],
    {
        i(1),
        i(0)
    })

    ),
}
