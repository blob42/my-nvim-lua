augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let g:lexical#thesaurus_key = '<leader>ts'
let g:lexical#thesaurus = ['~/.local/share/mthesaur.txt',]


