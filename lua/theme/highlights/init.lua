local Color, colors, Group, groups, styles = require('colorbuddy').setup {}
local modifiers = require('colorbuddy.modifiers').modifiers

local blob42 = require("custom.themes.blob42")

Color.new("green", blob42.base_30.green)
Color.new("yellow", blob42.base_30.yellow)
Color.new("sun", blob42.base_30.sun)
Color.new("base03", blob42.base_16.base03)
Color.new("dap_stop", "#ff4848")
Color.new("dap_virtual_text", "#f99540")

-- text
Group.new("MatchWord", colors.primary, colors.noir_8, styles.bold)
Group.link("MatchParen", groups.MatchWord )

Group.new("Error", colors.primary, nil, styles.underline)


-- search
-- select

-- menus
Group.new("PmenuSel", nil, colors.noir_8 )

Group.new('LineNr', colors.gray2:light())
Group.new('CursorLineNr', colors.gray3)

Group.new('telescopepromptcounter', colors.gray3)
Group.new('DiagnosticUnderlineError', colors.primary, nil, styles.underline)

-- syntax / treesitter
Group.new("Keyword", colors.primary, nil, styles.bold)
Group.link("@keyword", groups.Keyword)
Group.link("@keyword.function", groups.Keyword)
Group.link("@conditional", groups.Keyword)

Group.new("Type", colors.secondary, nil)
Group.link("@type", groups.Type)

Group.new("Macro", colors.primary)
Group.link("@function.macro", groups.Macro)

Group.new("String", colors.sun)
Group.link("@string", groups.String)
Group.new("@string.escape", colors.secondary)

Group.link("@constant.builtin", groups.Constant)
Group.link("@constant", groups.Constant)

Group.new("@variable", colors.noir_0)


--  indentline
Group.new("IndentBlanklineContextStart", colors.base03)

-- Dap

-- Migrating from nvchad custom added hilights
Group.new("DapStopped", colors.dap_stop)
Group.link("DapUIStop", groups.DapStopped)
Group.new("NvimDapVirtualText", colors.dap_virtual_text)
Group.new("DapUIWatchesEmpty", colors.secondary)


 
-- Override specific highlight groups...
-- Group.new('TelescopeTitle', colors.primary)
-- Group.new('TelescopeBorder', colors.secondary)
-- Group.new('CursorLineNr', colors.primary, colors.noir_9)
-- Group.new('Searchlight', nil, colors.secondary)
-- Group.new('@comment', colors.noir_7)
-- Group.new('@punctuation', colors.noir_2)
--
-- Add font styles to highlight groups...
-- Group.new('@constant', colors.noir_2, nil, styles.bold)
-- Group.new('@method', colors.noir_0, nil, styles.bold + styles.italic)

-- Link highlight groups...
-- Group.link('SignifySignAdd', groups.DiffAdd)
-- Group.link('SignifySignChange', groups.DiffChange)
-- Group.link('SignifySignDelete', groups.DiffDelete)
--

-- etc.
