nnoremap <leader>I :tab Info<CR>
augroup INFO
  au!
  au FileType info nnoremap i <NOP>
  au FileType info nmap <buffer> <Up>     <Plug>(InfoUp)
  au FileType info nmap <buffer> iu       <Plug>(InfoUp)
  au FileType info nmap <buffer> <Down>   <Plug>(InfoMenu)
  au FileType info nmap <buffer> im       <Plug>(InfoMenu)
  au FileType info nmap <buffer> <C-F>    <Plug>(InfoFollow)
  au FileType info nmap <buffer> if       <Plug>(InfoFollow)
  au FileType info nmap <buffer> <Right>  <Plug>(InfoNext)
  au FileType info nmap <buffer> in       <Plug>(InfoNext)
  au FileType info nmap <buffer> <Left>   <Plug>(InfoPrev)
  au FileType info nmap <buffer> ip       <Plug>(InfoPrev)
  au FileType info nmap <buffer> ig       <Plug>(InfoGoto)
augroup END
