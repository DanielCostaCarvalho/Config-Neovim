call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'NLKNguyen/papercolor-theme'
Plug 'folke/which-key.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'ahmedkhalf/project.nvim'
Plug 'TimUntersberger/neogit'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'goolord/alpha-nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'windwp/nvim-autopairs'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'folke/trouble.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'
Plug 'olimorris/neotest-phpunit'
Plug 'theutz/neotest-pest'
Plug 'nvim-neotest/neotest-vim-test'
Plug 'ThePrimeagen/refactoring.nvim'

" lsp
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'VonHeikemen/lsp-zero.nvim'

" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'

" snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'

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

set clipboard+=unnamedplus

set completeopt=menuone,noinsert,noselect

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let mapleader="\<space>"

tnoremap <Esc> <C-\><C-n>

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
        k = { "<cmd>bdelete<cr>", "Kill" },
        c = { 
          name = "+close",
          c = { "<cmd>bdelete<cr>", "Close current" },
          p = {"<cmd>BufferLinePickClose<cr>", "Pick to close" },
          l = {"<cmd>BufferLineCloseLeft<cr>", "Close all left" },
          r = {"<cmd>BufferLineCloseRight<cr>", "Close all right" },
        },
        o = {
          name = "+order",
          h = { "<cmd>BufferLineMovePrev<cr>", "Prev" },
          l = { "<cmd>BufferLineMoveNext<cr>", "Next" },
          p = { "<cmd>BufferLineTogglePin<cr>", "Pin" },
        },
        p = { "<cmd>BufferLinePick<cr>", "Pick" },
        h = { "<cmd>BufferLineCyclePrev<cr>", "Prev" },
        l = { "<cmd>BufferLineCycleNext<cr>", "Next" },
      },
      f = {
        name = "+file",
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        n = { "<cmd>enew<cr>", "New File" },
      },
      o = {
        name = "+open",
        p = {"<cmd>NvimTreeFindFileToggle<cr>", "Project sidebar"},
        t = {"<cmd>ToggleTerm<cr>", "Terminal"},
      },
      g = {
        name = "+git",
        g = {"<cmd>Neogit<cr>", "Open neogit"},
      },
      p = {
        name = "+Projects",
        p = {"<cmd>Telescope projects<cr>", "Open project"},
      },
      l = {
        name = "+LSP",
        m = {"<cmd>Mason<cr>", "Manage LSP"},
        l = {"<cmd>TroubleToggle<cr>", "List diagnostics"},
        a = {"<cmd>TroubleToggle quickfix<cr>", "List diagnostics quickfix"},
        d = {"<cmd>TroubleToggle lsp_definitions<cr>", "Show definitions"},
        t = {"<cmd>TroubleToggle lsp_type_definitions<cr>", "Show type definitions"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "Show references"},
      },
      r = {
        name = "+Refactoring",
        r = {"<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Select refactoring"},
      },
    },
  })

  require("project_nvim").setup {}
  require('telescope').load_extension('projects')
  require('telescope').load_extension('refactoring')
  require("nvim-tree").setup()
  require"alpha".setup(require"alpha.themes.dashboard".config)
  require("bufferline").setup{
    options = {
      numbers = "ordinal",
      diagnostics = "nvim_lsp"
    }
  }
  require('gitsigns').setup()
  require("toggleterm").setup()
  require('refactoring').setup({})

  local lsp = require('lsp-zero')

  lsp.preset('recommended')

  lsp.nvim_workspace()
  lsp.setup()

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

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
      require("neotest-phpunit"),
      require('neotest-pest')({
        pest_cmd = function()
          return "vendor/bin/pest"
        end
      }),
      require("neotest-vim-test")({ ignore_filetypes = { "php" } }),
    },
  })
EOF
