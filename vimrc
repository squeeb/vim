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
let g:airline_powerline_fonts = 1

" NERDTree
map <leader>N :NERDTreeToggle<CR>
let g:Tlist_WinWidth=60

" indentLine
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['json']

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
set winwidth=84
set colorcolumn=80              " highlight at 80 characters
set mouse=a
set noea


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

" ============================================================================
" NUMBER INCREMENT/DECREMENT
" ============================================================================

nnoremap + <C-a>
nnoremap - <C-x>

" ============================================================================
" HIGHLIGHTING
" ============================================================================

hi NoneText ctermbg=NONE cterm=NONE ctermfg=6
hi SpecialKey ctermbg=NONE cterm=NONE ctermfg=6

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
