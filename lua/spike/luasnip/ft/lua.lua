---@diagnostic disable: unused-local

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
-- local isn = ls.indent_snippet_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local m = extras.m
-- local l = extras.l
-- local rep = extras.rep
-- local postfix = require("luasnip.extras.postfix").postfix
--
-- add_snippet helper
local add_snippet = require("spike.snips").add_snippet


--HACK: remove after testing snippets or it resets all imported snippets
-- require("luasnip.session.snippet_collection").clear_snippets "lua"

add_snippet {
    lua = {
    }
}
