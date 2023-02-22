"Shift key typos
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

" preview markdown in browser
command! -bang MDPreview silent !md2html --github % | pipe-to-browser 

" migrate git config to blob42
command! -bang GitBlob42 %S/sp4ke.{xyz,com}/blob42.xyz/ge|%S/sp4ke/blob42/ge
