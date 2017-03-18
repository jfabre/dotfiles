call pathogen#infect()
syntax on
filetype plugin indent on
" colors ir_black
" colors Tomorrow-Night-Eighties
colors Tomorrow-Night-Eighties

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
set guifont=Monaco:h15
if exists('&transparency')
  set transparency=50
endif
" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>r :RunSpec<CR>
nmap <leader>l :RunSpec<CR>
nnoremap Q <nop>

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/


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
:vnoremap pg :!psql development -e<CR>
:vnoremap p2 :Shell psql development -e

set wildignore+=*/tmp/*,*/cache/*,*.so,*.swp,*.zip,*/data/*    " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
