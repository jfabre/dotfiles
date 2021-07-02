" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'preservim/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'kevinhui/vim-docker-tools'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-haml'

" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
Plug 'idanarye/vim-merginal'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails'
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'bronson/vim-trailing-whitespace'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Initialize plugin system
call plug#end()


lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

syntax on
filetype plugin on
filetype plugin indent on

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
syntax enable

" colors codeschool
" colors dusk
" colors ekvoli
" colors ir_black
" colors jellybeans
 colors motus
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

" 256 colors terminal
let &t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm

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

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

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

"set rtp+=/home/jeremy/bin/fzf

function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

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
