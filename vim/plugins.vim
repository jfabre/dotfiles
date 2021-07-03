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

Plug 'idanarye/vim-merginal'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails'
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'bronson/vim-trailing-whitespace'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rhysd/committia.vim'

"Colors
"
Plug 'andreasvc/vim-256noir'
Plug 'tlhr/anderson.vim'
Plug 'romainl/Apprentice'
Plug 'Badacadabra/vim-archery'
Plug 'gregsexton/Atom'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'ajmwagar/vim-deus'
Plug 'wadackel/vim-dogrun'
Plug 'whatyouhide/vim-gotham'
Plug 'cseelus/vim-colors-lucid'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'chriskempson/base16-vim'

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
