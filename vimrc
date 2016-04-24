"" Pathogen
execute pathogen#infect()

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,/tmp
set directory=~/.vim-tmp,/tmp

" Mappings
let mapleader=","               " use , as leader instead of backslash

set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number
set t_Co=256

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set scrolloff=999               " Keep the cursor in the middle of the screen

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Theme
syntax enable
colorscheme solarized
set background=dark
set cursorline                  " highlight current line
set list                        " turn on invisible characters
set listchars=tab:▸\ ,trail:▝   " which characters to highlight

"" vim-airline
let g:airline_powerline_fonts = 1

"" Window
set laststatus=2                " always show status line
set showtabline=2               " always show tab bar
set winwidth=84                 "
set colorcolumn=80              " highlight at 80 characters

" Tabs
nmap <leader>[ :tabp<cr>
nmap <leader>] :tabn<cr>
nmap T :tabnew<cr>

" navigate buffers
nmap <C-n> :bnext<CR>
nmap <C-b> :bprev<CR>

" remove whitespace
map <leader>s :%s/\s\+$//<CR>

" clear the search buffer
nnoremap <CR> :nohlsearch<cr>

" Retain indent when pasting code
nnoremap <leader>pt :set invpaste paste?<CR>
set pastetoggle=<leader>pt

set showmode

" NERDTree
" autocmd StdinReadPre * let s:std_in=1
map <leader>N :NERDTreeToggle<CR>

" tab autocomplete
set wildmenu
set wildmode=longest,list

hi NoneText ctermbg=NONE cterm=NONE ctermfg=6
hi SpecialKey ctermbg=NONE cterm=NONE ctermfg=6
