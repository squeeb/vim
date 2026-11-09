" Never re-indent the line being left; only the new line gets indented.
setlocal indentkeys-=*<Return>
setlocal indentkeys-=0-
setlocal nocindent
" Unfuck polyglot tabbing
setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
