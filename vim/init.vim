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
 colors jellybeans
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
" colors Tomorrow-Night-Eighties
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

" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
let mapleader = ","

nmap <leader>v :tabedit $MYVIMRC<CR>

nmap <Leader>e :call RunNearestSpec()<CR>
nmap <Leader>r :call RunCurrentSpecFile()<CR>
nmap <Leader>t :call RunAllSpecs()<CR>
let g:rspec_runner = "os_x_iterm2"
if has("nvim")
  let g:rspec_command = "tabnew | term bundle exec rspec {spec}"
endif

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
:vnoremap pg :!psql jeremy -e -d codescout<CR>
:vnoremap p2 :Shell psql jeremy -e

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*     " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_follow_symlinks = 1
" let g:ctrlp_max_files=0
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" The Silver Searcher
" if executable('ag')
  " Use ag over grep
"  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
"  let g:ctrlp_use_caching = 0
" endif

set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :Files<Cr>
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

let g:vimrubocop_keymap = 0
nmap <Leader>q :RuboCop<CR>

" Deal with white spaces
" set hls
" let g:HLSpace = 1
" let g:HLColorScheme = g:colors_name

