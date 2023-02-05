set formatoptions+=r " auto add comments on line return

" formatting with gofmt
" au BufEnter *.go set formatprg=gofmt\ -s
" au BufEnter *.go set formatprg=goimports
"
nnoremap <Space>fm :%!goimports<CR>
