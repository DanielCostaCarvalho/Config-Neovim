call plug#begin()
Plug 'editorconfig/editorconfig-vim' " add editorconfig

Plug 'nvim-lua/plenary.nvim' " dependency
Plug 'ahmedkhalf/project.nvim' " manage projects
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " multi-line edit
Plug 'ThePrimeagen/refactoring.nvim' " auto refactoring

" Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-ui-select.nvim'

" Visual
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'vim-airline/vim-airline'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'goolord/alpha-nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Git
Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'

" Tests
Plug 'nvim-neotest/neotest'
Plug 'olimorris/neotest-phpunit'
Plug 'theutz/neotest-pest'
Plug 'nvim-neotest/neotest-vim-test'

" Motion
Plug 'ggandor/leap.nvim'

" lsp
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'folke/trouble.nvim'

" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'windwp/nvim-autopairs'

" snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'

" key bindings
Plug 'folke/which-key.nvim'

call plug#end()

colorscheme PaperColor

set guifont=Jetbrains\ Mono:h12
set number relativenumber
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
set scrolloff=4

set clipboard+=unnamedplus

set completeopt=menuone,noinsert,noselect

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let mapleader="\<space>"

tnoremap <Esc> <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

lua << EOF
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  local wk = require("which-key")

  wk.setup {
  }

  wk.register({
    ["<leader>"] = {
      ["<leader>"] = {
        "<cmd>Telescope find_files<cr>", "Find File"
      },
      b = {
        name = "+buffer",
        a = { "<cmd>Telescope buffers<cr>", "List [A]ll" },
        k = { "<cmd>bdelete<cr>", "[K]ill" },
        c = { 
          name = "+close",
          c = { "<cmd>bdelete<cr>", "Close [C]urrent" },
          p = {"<cmd>BufferLinePickClose<cr>", "[P]ick to close" },
          l = {"<cmd>BufferLineCloseLeft<cr>", "Close all [L]eft" },
          r = {"<cmd>BufferLineCloseRight<cr>", "Close all [R]ight" },
        },
        o = {
          name = "+order",
          h = { "<cmd>BufferLineMovePrev<cr>", "Prev" },
          l = { "<cmd>BufferLineMoveNext<cr>", "Next" },
          p = { "<cmd>BufferLineTogglePin<cr>", "[P]in" },
        },
        p = { "<cmd>BufferLinePick<cr>", "[P]ick" },
        h = { "<cmd>BufferLineCyclePrev<cr>", "Prev" },
        l = { "<cmd>BufferLineCycleNext<cr>", "Next" },
      },
      f = {
        name = "+file",
        f = { "<cmd>Telescope find_files<cr>", "[F]ind File" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open [R]ecent File" },
        n = { "<cmd>enew<cr>", "[N]ew File" },
      },
      o = {
        name = "+open",
        p = {"<cmd>NvimTreeFindFileToggle<cr>", "[P]roject sidebar"},
        t = {"<cmd>ToggleTerm<cr>", "[T]erminal"},
        s = {"<cmd>lua require('neotest').summary.toggle()<CR>", "Show test [S]ummary"},
      },
      g = {
        name = "+git",
        g = {"<cmd>Neogit<cr>", "Open neogit"},
      },
      p = {
        name = "+Projects",
        p = {"<cmd>Telescope projects<cr>", "Open [P]roject"},
        s = {"<cmd>Telescope live_grep<cr>", "[S]earch in project"},
        f = {"<cmd>Telescope find_files<cr>", "Find [F]ile"},
      },
      s = {
        name = "+Search",
        p = {"<cmd>Telescope live_grep<cr>", "Search in [P]roject"},
        w = {"<cmd>Telescope grep_string<cr>", "Search [W]ord in Project"},
        r = {[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and [R]eplace"},
      },
      l = {
        name = "+LSP",
        m = {"<cmd>Mason<cr>", "[M]anage LSP"},
        a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ctions"},
        l = {"<cmd>TroubleToggle document_diagnostics<cr>", "[L]ist diagnostics"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "List diagnostics [Q]uickfix"},
        d = {"<cmd>TroubleToggle lsp_definitions<cr>", "Show [D]efinitions"},
        t = {"<cmd>TroubleToggle lsp_type_definitions<cr>", "Show [T]ype definitions"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "Show [R]eferences"},
      },
      t = {
        name = "+Test",
        r = {"<cmd>lua require('neotest').run.run()<CR>", "[R]un tests"},
        o = {"<cmd>lua require('neotest').output_panel.toggle()<CR>", "Show tests [O]utput"},
        s = {
          name = "+Summary",
          s = {"<cmd>lua require('neotest').summary.toggle()<CR>", "[S]how summary"},
          r = {"<cmd>lua require('neotest').summary.run_marked()<CR>", "[R]un marked"},
          m = {"<cmd>lua require('neotest').summary.marked()<CR>", "Show [M]arked"},
        }
      },
    },
  })

  wk.register({
    ["<leader>"] = {
      r = {
        name = "+Refactoring",
        r = {"<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Select refactoring"},
      },
    },
  },
  {mode = "v"})

  require("project_nvim").setup {}
  require('telescope').load_extension('projects')
  require('telescope').load_extension('refactoring')
  require('telescope').load_extension('ui-select')
  require("nvim-tree").setup({
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
  })
  require"alpha".setup(require"alpha.themes.dashboard".config)
  require("bufferline").setup{
    options = {
      numbers = "ordinal",
      diagnostics = "nvim_lsp",
      offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
        }
      },
    }
  }
  require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 0,
      ignore_whitespace = false,
    },
  })
  require("toggleterm").setup()
  require('refactoring').setup({})

  local lsp = require('lsp-zero')

  lsp.preset('recommended')

  lsp.nvim_workspace()
  lsp.setup_nvim_cmp({
    completion = {
      keyword_length = 1
    },
    sources = {
      {name = "nvim_lsp", keyword_length = 1},
      {name = "luasnip", keyword_length = 1},
    },
  })

  local cmp = require('cmp')
  local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.complete(),
  })

  lsp.setup_nvim_cmp({
    mapping = cmp_mappings
  })
  
  lsp.setup()

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.cspell.with({
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity["WARN"]
        end,
      }),
      null_ls.builtins.code_actions.cspell,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.formatting.pint,
      null_ls.builtins.diagnostics.phpstan,
      null_ls.builtins.formatting.blade_formatter,
    },
    diagnostics_format = "#{m} - #{s} (#{c})",
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({bufnr = bufnr})
          end,
        })
      end
    end,
  })
  require("nvim-autopairs").setup {}
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  require("neotest").setup({
    adapters = {
      -- require("neotest-phpunit"),
      require('neotest-pest')({
        pest_cmd = function()
          return "vendor/bin/pest"
        end
      }),
      require("neotest-vim-test")({ ignore_filetypes = { "php" } }),
    },
  })
  require('leap').add_default_mappings()
EOF
