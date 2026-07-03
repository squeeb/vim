setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal formatoptions=crnqj

" run buffer in python
nnoremap <buffer> <leader>r :exec '!clear;python' shellescape(@%, 1)<cr>
