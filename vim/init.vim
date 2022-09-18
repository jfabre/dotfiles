syntax on
filetype plugin on
filetype plugin indent on

" vim plug
source ~/dotfiles/vim/plugins.vim

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
syntax enable

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

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
let mapleader = ","

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"au BufWritePost ~/dotfiles/vim/init.vim so $MYVIMRC
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>b :tabedit ~/.vim/plugins.vim<CR>

tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>

nnoremap <leader>d :DockerToolsToggle<Cr>
nnoremap <leader>z :Git blame<Cr>

let test#neovim#term_position = "vert topleft 120"
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

nnoremap Q <nop>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

let g:airline_section_b = ''

let b:ale_linters = ['eslint', 'rubocop']
let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
" Write this in your vimrc file
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0

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

autocmd FileType ruby
    \ set foldmethod=expr |
    \ set foldexpr=getline(v:lnum)=~'^\\s*#'

:2mat ErrorMsg '\%81v.'

lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { ".git", "deps", "_build" }
  }
}
EOF

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['solargraph'].setup {
    capabilities = capabilities
  }
EOF

colors base16-embers
