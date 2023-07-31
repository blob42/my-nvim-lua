-- vim modeline
-- vim: foldmarker={,} foldmethod=marker foldlevel=0

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local windowGroup = augroup("dkowindow", {})

-- FIXME: temporary fix for bug introduced in
-- https://github.com/neovim/neovim/commit/d52cc668c736ef6ca7ee3655a7eb7fe6475afadc
-- https://github.com/davidosomething/dotfiles/commit/95c0ac68936a8517d9c60b3e461b3e7b7fd076c1
-- Remove on next update
autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
        "i",
        false
      )
    end
  end,
  desc = "https://github.com/nvim-telescope/telescope.nvim/issues/2027",
  group = windowGroup,
})

-- window closing
-- TODO: using dynamic C-x command
-- if character under cursor is number
-- use normal C-x or close window

--


-- highlights {
  -- handled in chadrc ui
  -- see also plugin/after highlihght.vim
  -- vim.cmd[[ runtime highlight.vim ]]
--}

-- Shift key typos{
-- vim.cmd [[
--     command! -bang -nargs=* -complete=file E e<bang> <args>
--     command! -bang -nargs=* -complete=file W w<bang> <args>
--     command! -bang -nargs=* -complete=file Wq wq<bang> <args>
--     command! -bang -nargs=* -complete=file WQ wq<bang> <args>
--     command! -nargs=* -complete=help H h <args>
--     command! -bang Wa wa<bang>
--     command! -bang WA wa<bang>
--     command! -bang Q q<bang>
--     command! -bang QA qa<bang>
--     command! -bang Qa qa<bang>
-- ]]
--}


-- suckless {
-- vim.cmd [[
--     " Autocompile suckless
--     " NOTE: symlinks do not work with autocommand patterns
--     let dwm_file_patterns = expand("/data/source/suckless/*/{config.h,*.c}")
--
--     augroup DWM
--       au!
--
--       "execute "au BufEnter " . dwm_file_patterns  . " :lcd %:p:h"
--       "execute "au BufWritePost " . dwm_file_patterns  . " :AsyncRun! make clean && make  && sudo make install"
--       "au BufWritePost */src/*/dwm*/{*.h,dwm.c} :AsyncRun! make clean && make && doas make install
--       au BufWritePost */suckless/*/{*.h,*.c} :AsyncRun! make clean && make && doas make install"
--     augroup END
-- ]]
--}

-- Make asyncrun work with fugitive {
-- vim.cmd [[
--   augroup asyncrun
--     au!
--     command -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
--   augroup END
-- ]]
--}

-- gopass{
-- vim.cmd [[
--   augroup gopass
--     au!
--     au BufNewFile,BufRead /dev/shm/gopass* setlocal noswapfile nobackup noundofile
--   augroup END
-- ]]
--}

-- plantuml {
-- vim.cmd [[
--     au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
--     \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
--     \  1,
--     \  0
--     \)
-- ]]
-- }
