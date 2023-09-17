" DWM
augroup DWM
    au BufWritePost */suckless/*/{*.c,*.h} :AsyncRun make && make install
"       au BufWritePost */suckless/*/{*.h,*.c} :AsyncRun! make clean && make && doas make install"
augroup END

augroup PlantUml
    au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)
augroup END


augroup gopass
    au!
    au BufNewFile,BufRead /dev/shm/gopass* setlocal noswapfile nobackup noundofile
augroup END

augroup asyncrun
    au!
    command -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
augroup END
