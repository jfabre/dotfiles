call pathogen#infect()
syntax on
filetype plugin indent on
colors codeschool 
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set number
set buftype=
let &t_Co=256
set hlsearch
set incsearch
set guifont=Monaco:h14
if exists('&transparency')
  set transparency=25
endif
" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif
let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>
