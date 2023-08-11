local M = {}

M.override = {
        -- IndentBlanklineContextChar = {
        --     fg = "baby_pink",
        --     nocombine = true,
        -- },
        -- IndentBlanklineChar= {
        --     fg = "black",
        --     nocombine = true,
        -- },
        Comment = {
            fg = "light_grey"
        },
        CursorLine = {
            bg = "#3b2a41"
        },
        CursorColumn = {
            bg = "#3b2a41"
        },
        -- ColorColumn = { -- outrun
        --     bg = "#3b2a41"
        -- },
        DiagnosticWarn = {
            fg = "yellow",
            italic = true,
        },
        St_LspWarning = {
            fg = "yellow"
        },
        DiagnosticHint = {
            fg = "purple",
            italic = true,
        },
        St_LspHints = {
            fg = "pruple",
        },
        DiagnosticError = {
            italic = true,
        },
        St_LspInfo = {
            fg = "white"
        },
        St_LspStatus = {
            fg = "blue"
        },
        -- LineNr = {
            -- fg = "#5f4468" -- outrun
        -- },
    }

M.add =  {
        -- Visual                   = {
        --     bg = "cyan",
        --     fg = "black",
        -- },
        BookmarkSign             = {
            fg = "blue",
        },
        BookmarkAnnotationSign   = {
            fg = "yellow",
        },
        BookmarkAnnotationLine   = {
            fg = "black",
            bg = "yellow"
        },
        DiagnosticInfo           = { -- nvchad uses DiagnosticInformation wrong hi group for lsp
            fg = "white",
            italic = true,
        },
        DiagnosticFloatingInfo   = {
            fg = "white",
            italic = true,
        },
        -- Definied in custom theme parameters (after/plugin/theme.lua)
        -- DiagnosticUnderlineError = {
        --     fg = "red",
        --     underline = true,
        -- },
        -- Code Lens related colors
        LspCodeLens              = {
            fg = "vibrant_green",
            underline = true,
        },
        LspDiagnosticsSignHint   = { -- LspDiagnostics Code Action
            fg = "vibrant_green",
            italic = true,
        },
        -- end of code lens colors
        DiffText                 = {
            bg = "vigrant_green"
        },
        St_DapMode               = {
            fg = "black2",
            bg = "baby_pink",
        },
        St_DapModeSep            = {
            fg = "baby_pink",
            bg = "one_bg3",
        },
        St_DapModeSep2           = {
            fg = "grey",
            bg = "baby_pink",
        },
        DapBreakpoint            = {
            fg = "green"
        },
        -- DapStopped               = {
        --     fg = "#ff4848"
        -- },
        DapLogPoint              = {
            fg = "vibrant_green"
        },
        DapBreakpointCondition   = {
            fg = "cyan"
        },
        DapBreakpointRejected   = {
            fg = "purple"
        },
        LuaSnipChoice = {
            fg = "yellow",
            bg = "one_bg3",
        },
        LuaSnipInsert = {
            fg = "teal",
            -- bg = "one_bg3",
        },
       --  NvimDapVirtualText = {
       --      fg = '#f99540'
       -- },
       TabLineSel = {
           fg = "white",
           bold = true
       },
       TreesitterContext = {
           bg = "one_bg3"
       }

    }


return M
