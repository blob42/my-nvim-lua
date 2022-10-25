" DWM
augroup DWM
    au BufWritePost */suckless/*/{*.c,*.h} :AsyncRun! make && doas make install
"       au BufWritePost */suckless/*/{*.h,*.c} :AsyncRun! make clean && make && doas make install"
augroup END
