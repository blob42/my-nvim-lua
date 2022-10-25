
- !{motion}{filter} filter text lines through ext program
- !!{filter} filter lines through ext program
- review using C-x C-l with context aware situation
- gR *virtual replace* mode

- C-\ atlernate between windows
- C-^ alternate buffer

- g;			Go to [count] older position in change list.
- g,			Go to [count] newer position in change list.

# Change in the last search patterns
- cgn : change to the last used  search patter ex:
/searchVar
cgn
newVar
. (keep pressing dot to repeat changes)

# Modeline errors
This erorr might appear: 
`Error detected while processing modelines:`
When there is a text somewhere that is recognized by vim as a modeline.

* ! solution: add a top of file # vim: nomodeline (replace `#' with comment char)


4. Named registers "a to "z or "A to "Z			quote_alpha quotea
Vim fills these registers only when you say so.  Specify them as lowercase
letters to replace their previous contents or as uppercase letters to append
to their previous contents.  When the '>' flag is present in 'cpoptions' then
a line break is inserted before the appended text.

## Neovim Lua Plugin Tips
- if a var needs to be accessed outside plugin and cannot be shared easilly
like from a scheduled func call or timer, save the var in vim.g and access it 
as global variable

