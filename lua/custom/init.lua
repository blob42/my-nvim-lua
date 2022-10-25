-- vim modeline
-- vim: foldmarker={,} foldmethod=marker foldlevel=0

-- local augroup = vim.api.nvim_create_augroup
-- local autocmd = vim.api.nvim_create_autocmd

-- window closing
-- TODO: using dynamic C-x command
-- if character under cursor is number
-- use normal C-x or close window

local vimscriptsfolder = vim.env.XDG_CONFIG_HOME .. "/nvim/myvimscript" -- relative to .config/nvim dir
vim.opt.runtimepath:prepend(vimscriptsfolder)


-- highlights {
  -- handled in chadrc ui
  -- see also plugin/after highlihght.vim
  -- vim.cmd[[ runtime highlight.vim ]]
--}

-- Shift key typos{
vim.cmd [[
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -nargs=* -complete=help H h <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
]]
--}

-- suckless {
vim.cmd [[
    " Autocompile suckless
    " NOTE: symlinks do not work with autocommand patterns
    let dwm_file_patterns = expand("/data/source/suckless/*/{config.h,*.c}")

    augroup DWM
      au!

      execute "au BufEnter " . dwm_file_patterns  . " :lcd %:p:h"
      execute "au BufWritePost " . dwm_file_patterns  . " :AsyncRun! make clean && make -j $(nproc) && sudo make install"
      "au BufWrite */src/*/dwm*/{*.h,dwm.c} :AsyncRun! make clean && make && sudo make install
    augroup END
]]
--}

-- Make asyncrun work with fugitive {
vim.cmd [[
  augroup asyncrun
    au!
    command -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
  augroup END
]]
--}

-- gopass{
vim.cmd [[
  augroup gopass
    au!
    au BufNewFile,BufRead /dev/shm/gopass* setlocal noswapfile nobackup noundofile
  augroup END
]]
--}

-- plantuml {
vim.cmd [[
    au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)
]]
-- }
