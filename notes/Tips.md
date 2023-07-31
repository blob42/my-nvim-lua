- remember live command
- !{motion}{filter} filter text lines through ext program
- !!{filter} filter lines through ext program
- review using C-x C-l with context aware situation
- gR *virtual replace* mode ( set ve=all | ve=none )

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


# Refactoring
* [refactoring article](https://alpha2phi.medium.com/neovim-for-beginners-refactoring-4f517d12a43f)
:argdo — Execute the command for each file in the argument list
:bufdo — Execute the command in each buffer in the buffer list
:tabdo — Execute the command in each tab page
:windo — Execute the command in each window
:cdo — Execute the command in each valid entry in the quickfix list (entry itself not the file)
:cfdo — Execute the command in each file in the quickfix list
:vimgrep `:vimgrep /<pattern>/ ##` where ## is replaces with files in arg list

## Filtering quickfix
`packadd cfilter`
`:Cfilter /pattern/`
`:Lfilter /pattern`

## Delete lines matching pattern
!! Use the :global command

    :g/profile/d
