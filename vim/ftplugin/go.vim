setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal nolist
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
