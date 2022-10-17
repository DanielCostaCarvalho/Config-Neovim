call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components'
Plug 'NLKNguyen/papercolor-theme'
Plug 'folke/which-key.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'ahmedkhalf/project.nvim'
Plug 'TimUntersberger/neogit'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'goolord/alpha-nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
call plug#end()

colorscheme PaperColor

set background=light
set hidden
set number
set mouse=a
set inccommand=split
set colorcolumn=80,120

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent

set clipboard+=unnamedplus

set completeopt=menuone,noinsert,noselect

let g:coc_node_path = '/home/daniel/.asdf/installs/nodejs/14.19.0/bin/node'

let g:coc_global_extensions = [
      \'coc-eslint',
      \'coc-tsserver',
      \'coc-prettier',
      \'coc-elixir',
      \'coc-json',
      \'coc-css',
      \'coc-html',
      \'coc-java',
      \'coc-pairs',
      \'coc-flutter',
      \'coc-php-cs-fixer',
      \'@yaegassy/coc-phpstan',
      \'coc-phpls',
      \'coc-spell-checker',
      \'coc-cspell-dicts'
      \]

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let mapleader="\<space>"

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) : 
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>"
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

lua << EOF
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  local wk = require("which-key")

  wk.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }


  wk.register({
    ["<leader>"] = {
      ["<leader>"] = {
        "<cmd>Telescope find_files<cr>", "Find File"
      },
      b = {
        name = "+buffer",
        k = { "<cmd>bdelete<cr>", "Kill" },
        c = { 
          name = "+close",
          c = { "<cmd>bdelete<cr>", "Close current" },
          p = {"<cmd>BufferLinePickClose<cr>", "Pick to close" },
          l = {"<cmd>BufferLineCloseLeft<cr>", "Close all left" },
          r = {"<cmd>BufferLineCloseRight<cr>", "Close all right" },
        },
        h = { "<cmd>BufferLineMovePrev<cr>", "Prev" },
        l = { "<cmd>BufferLineMoveNext<cr>", "Next" },
        l = { "<cmd>BufferLineTogglePin<cr>", "Pin" },
      },
      f = {
        name = "+file",
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        n = { "<cmd>enew<cr>", "New File" },
      },
      o = {
        name = "+open",
        p = {"<cmd>NvimTreeToggle<cr>", "Project sidebar"}
      },
      g = {
        name = "+git",
        g = {"<cmd>Neogit<cr>", "Open neogit"}
      },
      p = {
        name = "+Projects",
        p = {"<cmd>Telescope projects<cr>", "Open project"}
      }
    },
  })

  require("project_nvim").setup {}
  require('telescope').load_extension('projects')
  require("nvim-tree").setup()
  require"alpha".setup(require"alpha.themes.dashboard".config)
  require("bufferline").setup{
    options = {
      numbers = "ordinal",
      diagnostics = "coc"
    }
  }
EOF
