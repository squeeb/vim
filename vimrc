" ============================================================================
" PLUGIN MANAGEMENT
" ============================================================================

" Pathogen
execute pathogen#infect()
filetype plugin indent on

" ============================================================================
" PLUGIN CONFIGURATION
" ============================================================================

" vim-airline
let g:airline_powerline_fonts = 1                                              " enable powerline fonts
let g:airline#extensions#tabline#buffer_nr_show = 0                            " don't show buffer number
let g:airline#extensions#tabline#enabled = 1                                   " enable tabline
let g:airline#extensions#tabline#buffer_idx_mode = 1                           " show index number on tabline for buffer

" NERDTree
map <leader>N :NERDTreeToggle<CR>
" let g:Tlist_WinWidth=60
let g:NERDTreeWinSize = 31

" Never let CTRL-W= or window-manager resizing touch NERDTree's width
autocmd FileType nerdtree setlocal winfixwidth

" Re-assert the width every time NERDTree becomes the visible buffer
" (covers the case where it was resized while hidden, then toggled back)
autocmd BufWinEnter * if &filetype ==# 'nerdtree' | exe 'vertical resize ' . g:NERDTreeWinSize | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" indentLine
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['json']
let g:indentLine_conceallevel = 0

" solarized
let g:solarized_bold       = 1
let g:solarized_underline  = 1
let g:solarized_italic     = 1
let g:solarized_contrast   = "high"
let g:solarized_visibility = "high"

" puppet
let g:puppet_align_hashes = 1

" disable JSON concealing
let g:vim_json_conceal = 0

" python
" https://github.com/vim-python/python-syntax
let g:python_highlight_all = 1
let g:python_pep8_indent_multiline_string = 1
let g:python_pep8_indent_hang_closing = 1

" ============================================================================
" BASIC SETTINGS
" ============================================================================

set nocompatible                " no legacy vi compatibility
set encoding=utf-8
set number                      " show line numbers
set ruler                       " show cursor position
set showcmd                     " display incomplete commands
set showmode                    " show current mode
set laststatus=2                " always show status line
set showtabline=2               " always show tab bar

" colors and theme
set t_Co=256
set background=dark
syntax enable
colorscheme solarized

" cursor highlighting
set cursorcolumn
" set cursorline                " uncomment to highlight current line

" window settings
"set winwidth=84
set colorcolumn=80              " highlight at 80 characters
set mouse=a
"set noea
set switchbuf=useopen           " don't open in new buffer if there's one open
set hidden                      " don't ask to save when switching buffers

" ============================================================================
" INDENTATION & WHITESPACE
" ============================================================================

set nowrap                      " don't wrap lines
set tabstop=2
set shiftwidth=2
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start
set cindent
set autoindent

" visualize invisible characters
set list
set listchars=tab:▸\ ,trail:•

" disable concealing
set conceallevel=0

" ============================================================================
" SEARCH
" ============================================================================

set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " case insensitive...
set smartcase                   " ...unless they contain uppercase

" clear search highlighting with Enter
nnoremap <CR> :nohlsearch<cr>

" ============================================================================
" FILE HANDLING
" ============================================================================

" store temporary files centrally
set backupdir=~/.vim-tmp,/tmp
set directory=~/.vim-tmp,/tmp
set noswapfile

" tab autocomplete
set wildmenu
set wildmode=longest,list

" ============================================================================
" LEADER KEY MAPPINGS
" ============================================================================

let mapleader="\\"

" toggle invisible characters
nmap <leader>l :call ToggleList()<cr>

" toggle tabs vs spaces
nmap <leader>t :call ToggleTabsVsSpaces()<cr>

" toggle paste mode
nnoremap <leader>pt :set invpaste paste?<CR>
set pastetoggle=<leader>pt

" remove trailing whitespace
map <leader>s :%s/\s\+$//<CR>

" replace double quotes with single quotes
map <leader>rq :%s/\"\([^"]*\)\"/'\1'/g<CR>

" align INI-style key=value pairs
xnoremap <leader>a :call AlignINI()<CR>

" insert current date in IEEE format (YYYY-MM-DD)
nnoremap <leader>d :read !date  +\%Y-\%m-\%d<CR>

" ============================================================================
" TAB NAVIGATION
" ============================================================================

nmap <leader>[ :tabp<cr>
nmap <leader>] :tabn<cr>
nmap T :tabnew<cr>

" ============================================================================
" BUFFER NAVIGATION
" ============================================================================

nmap <C-n> :bnext<CR>
nmap <C-b> :bprev<CR>
nmap <leader>q :BW<CR>
" probably a better way to switch buffers by index but meh
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
" ============================================================================
" NUMBER INCREMENT/DECREMENT
" ============================================================================

nnoremap + <C-a>
nnoremap - <C-x>

" ============================================================================
" FOLDING
" ============================================================================

set nofoldenable
nnoremap <Space> za
vnoremap <Space> za


" ============================================================================
" HIGHLIGHTING
" ============================================================================

hi NoneText ctermbg=NONE cterm=NONE ctermfg=6
hi SpecialKey ctermbg=NONE cterm=NONE ctermfg=6

" ===========================================================================
" CLIPBOARD
" ===========================================================================

if executable('wl-copy') && $WAYLAND_DISPLAY != ''
  " Yank to system clipboard
  vnoremap <silent> "+y y:call system('wl-copy', @")<CR>
  nnoremap <silent> "+yy yy:call system('wl-copy', @")<CR>

  " Paste from system clipboard
  nnoremap <silent> "+p :call setreg('"', system('wl-paste --no-newline'))<CR>p
  nnoremap <silent> "+P :call setreg('"', system('wl-paste --no-newline'))<CR>P
endif

" ============================================================================
" FUNCTIONS
" ============================================================================

function! ToggleList()
  if &list
    setlocal nolist
    echo "Whitespace highlight off"
  else
    setlocal list
    echo "Whitespace highlight on"
  endif
endfunction

function! ToggleTabsVsSpaces()
  if &expandtab
    setlocal noet ci pi sts=0 sw=4 ts=4
    echo "No expand tabs"
  else
    setlocal et ci pi sts=0 sw=2 ts=2
    echo "Expand tabs"
  endif
endfunction

function! AlignINI() range
  " find the longest key length in the selected lines
  let maxlen = max(map(getline(a:firstline, a:lastline),
        \ {_, v -> strlen(matchstr(v, '^[^=]*'))}))
  " align each line
  execute a:firstline . ',' . a:lastline . 's/^\([^=]*\)=\(.*\)/\=printf("%-*s = %s", maxlen, trim(submatch(1)), trim(submatch(2)))/'
endfunction
