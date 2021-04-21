call pathogen#infect()
syntax on
filetype plugin on
filetype plugin indent on

" colors codeschool
" colors darkburn
" colors dusk
" colors earendel
" colors ekvoli
" colors freya
" colors fu
" colors gentooish
" colors herald
" colors inkpot
" colors ir_black
" colors jellybeans
" colors lettuce
" colors molokai
" colors moss
" colors motus
" colors Mustang
" colors oceanblack
" colors paradox
" colors peaksea
" colors solarized
" colors synic
" colors tir_black
" colors Tomorrow-Night-Blue
" colors Tomorrow-Night-Bright
colors Tomorrow-Night-Eighties
" colors Tomorrow-Night
" colors Tomorrow
" colors wombat256mod
" colors wombat256
" colors xoria256

set clipboard=unnamed
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
set nocompatible

" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
let mapleader = ","

:nnoremap <leader>t    :tabnew<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>

nnoremap <leader>f :GFiles --exclude-standard --others --cached<Cr>
nnoremap <leader>g :Files<Cr>
nnoremap <leader>d :DockerToolsToggle<Cr>
nnoremap <leader>b :Merginal<Cr>
nnoremap <leader>z :Git blame<Cr>

let test#neovim#term_position = "vert topleft 120"
nmap <Leader>e :TestNearest -strategy=neovim<CR>
nmap <Leader>r :TestFile --fail-fast -strategy=neovim<CR>
nmap <Leader>t :TestSuite --fail-fast -strategy=neovim<CR>

nnoremap Q <nop>

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" not a good idea
":set shellcmdflag=-ic
":set shell /usr/bin/zsh
"
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  echo 'Execute ' . command . '...'
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

" maps pgsql to pgsql
:vnoremap pg :!psql -e -x<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*     " MacOSX/Linux

set rtp+=/usr/local/opt/fzf

" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

let g:vimrubocop_rubocop_cmd = 'rubocop '
let g:vimrubocop_config = '.rubocop.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>q :RuboCop<CR>


:command -nargs=+ Gg execute 'silent Ggrep!' <q-args> | cw | redraw!

autocmd FileType ruby,eruby
      \ set foldmethod=expr |
      \ set foldexpr=getline(v:lnum)=~'^\\s*#'

:2mat ErrorMsg '\%81v.'
