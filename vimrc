" Pathogen
execute pathogen#infect()

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,/tmp
set directory=~/.vim-tmp,/tmp

" mappings
let mapleader="\\"

set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number
set t_Co=256
set background=dark

" whitespace
set nowrap                      " don't wrap lines
set tabstop=2
set shiftwidth=2                " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set cindent                 " smart indent
set autoindent

" searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" theme
syntax enable
" set cursorline                  " highlight current line
set cursorcolumn
set list                        " turn on invisible characters
set listchars=tab:▸\ ,trail:•   " which characters to highlight

nmap <leader>l :call ToggleList()<cr>

function! ToggleList()
  if &list
    setlocal nolist
    echo "Whitespace highlight off"
  else
    setlocal list
    echo "Whitespace highlight on"
  endif
endfunction
"" set theme based on time
"let colorflag = system("cat /tmp/terminalcolor")
"if colorflag == 1
"  set background=light
"else " Set to dark from 7pm to 7am
"  set background=dark
"endif

" vim-airline
let g:airline_powerline_fonts = 1

" window
set laststatus=2                " always show status line
set showtabline=2               " always show tab bar
set winwidth=84                 "
set colorcolumn=80              " highlight at 80 characters
set mouse=a
set noea
" tabs
nmap <leader>[ :tabp<cr>
nmap <leader>] :tabn<cr>
nmap T :tabnew<cr>

" toggle spaces vs tabs
nmap <leader>t :call ToggleTabsVsSpaces()<cr>

function! ToggleTabsVsSpaces()
  if &expandtab
    setlocal noet ci pi sts=0 sw=4 ts=4
    echo "No expand tabs"
  else
    setlocal et ci pi sts=0 sw=2 ts=2
    echo "Expand tabs"
  endif
endfunction

" navigate buffers
nmap <C-n> :bnext<CR>
nmap <C-b> :bprev<CR>
nmap <leader>q :BW<CR>

" remove whitespace
map <leader>s :%s/\s\+$//<CR>

" clear the search buffer
nnoremap <CR> :nohlsearch<cr>

" retain indent when pasting code
nnoremap <leader>pt :set invpaste paste?<CR>
set pastetoggle=<leader>pt

set showmode

" NERDTree
" autocmd StdinReadPre * let s:std_in=1
map <leader>N :NERDTreeToggle<CR>
let g:Tlist_WinWidth=60

" replace quotes
map <leader>rq :%s/\"\([^"]*\)\"/'\1'/g<CR>

" tab autocomplete
set wildmenu
set wildmode=longest,list

" highlight colors
hi NoneText ctermbg=NONE cterm=NONE ctermfg=6
hi SpecialKey ctermbg=NONE cterm=NONE ctermfg=6

" puppet plugin options
let g:puppet_align_hashes = 1

" increment next/previous number
nnoremap + <C-a>
nnoremap - <C-x>

" run buffer in python
nnoremap <buffer> <leader>r :exec '!clear;python' shellescape(@%, 1)<cr>

" some useful Ruby filetype settings
augroup RubyShenanigans
  au!
  autocmd BufRead,BufNewFile Gemfile,Rakefile,Capfile,Vagrantfile
    \ set filetype=ruby

" disable swapfile
set noswapfile

" sections (a, b, c, x, y, z, warn) are optional
"let g:promptline_preset = {
"        \'b' : [ promptline#slices#user() ],
"        \'c' : [ promptline#slices#cwd() ],
"        \'y' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
"        \'warn' : [ promptline#slices#last_exit_code() ]}
"
" let g:solarized_termcolors=   256
" let g:solarized_termtrans =   1
" let g:solarized_degrade   =   1
let g:solarized_bold      =   1
let g:solarized_underline =   1
let g:solarized_italic    =   1
let g:solarized_contrast  =   "high"
let g:solarized_visibility=   "high"
" let g:jedi#rename_command = "<leader>rn"
colorscheme solarized
let g:indentLine_char     =   '│'

set ruler

let g:python_pep8_indent_hang_closing = 1

" Align INI-style key=value pairs
function! AlignINI() range
  " find the longest key length in the selected lines
  let maxlen = max(map(getline(a:firstline, a:lastline),
        \ {_, v -> strlen(matchstr(v, '^[^=]*'))}))

  " align each line
  execute a:firstline . ',' . a:lastline . 's/^\([^=]*\)=\(.*\)/\=printf("%-*s = %s", maxlen, trim(submatch(1)), trim(submatch(2)))/'
endfunction

" Map \a to align selected lines
xnoremap <leader>a :call AlignINI()<CR>
