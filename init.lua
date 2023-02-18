vim.opt.guifont = "Jetbrains Mono:h12"
vim.opt.background = "light"
vim.opt.hidden = true
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.mouse = "a"
vim.opt.inccommand = "split"
vim.opt.colorcolumn = "80,120"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.scrolloff = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menuone,noinsert,noselect"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  'editorconfig/editorconfig-vim',
  'nvim-lua/plenary.nvim',
  { 'ahmedkhalf/project.nvim',       config = {},      name = 'project_nvim' }, -- manage projects
  { 'mg979/vim-visual-multi',        branch = 'master' }, -- multi-line edit
  { 'ThePrimeagen/refactoring.nvim', config = true }, -- auto refactoring

  -- Telescope
  { 'nvim-telescope/telescope.nvim', version = '0.1.0' },
  'nvim-telescope/telescope-ui-select.nvim',

  -- Visual
  'nvim-treesitter/nvim-treesitter',
  'vim-airline/vim-airline',
  { 'akinsho/bufferline.nvim', version = 'v3.*',
    opts = {
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
  },
  { 'NLKNguyen/papercolor-theme', lazy = false },
  'goolord/alpha-nvim',
  'nvim-tree/nvim-web-devicons',
  { 'nvim-tree/nvim-tree.lua',
    opts = {
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
    }
  },
  { 'akinsho/toggleterm.nvim',    version = '*', config = true },

  -- Git
  'TimUntersberger/neogit',
  { 'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
      },
    }
  },

  -- Tests
  { 'nvim-neotest/neotest',
    config = function()
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
    end
  },
  'olimorris/neotest-phpunit',
  'theutz/neotest-pest',
  'nvim-neotest/neotest-vim-test',

  -- HTTP requests
  { "rest-nvim/rest.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      jump_to_request = true,
    }
  },

  -- Motion
  'ggandor/leap.nvim',

  -- lsp
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'VonHeikemen/lsp-zero.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  { 'folke/trouble.nvim',    config = true },

  -- autocomplete
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'saadparwaiz1/cmp_luasnip',
  { 'windwp/nvim-autopairs', config = true },

  -- snippets
  'rafamadriz/friendly-snippets',
  'L3MON4D3/LuaSnip',

  -- key bindings
  { 'folke/which-key.nvim', config = true },
})

vim.cmd.colorscheme("PaperColor")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local wk = require("which-key")

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
        p = { "<cmd>BufferLinePickClose<cr>", "[P]ick to close" },
        l = { "<cmd>BufferLineCloseLeft<cr>", "Close all [L]eft" },
        r = { "<cmd>BufferLineCloseRight<cr>", "Close all [R]ight" },
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
      L = { "<cmd>Telescope buffers<cr>", "[L]ist all" },
    },
    f = {
      name = "+file",
      f = { "<cmd>Telescope find_files<cr>", "[F]ind File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open [R]ecent File" },
      n = { "<cmd>enew<cr>", "[N]ew File" },
    },
    o = {
      name = "+open",
      p = { "<cmd>NvimTreeFindFileToggle<cr>", "[P]roject sidebar" },
      t = { "<cmd>ToggleTerm<cr>", "[T]erminal" },
      s = { "<cmd>lua require('neotest').summary.toggle()<CR>", "Show test [S]ummary" },
    },
    g = {
      name = "+git",
      g = { "<cmd>Neogit<cr>", "Open neogit" },
    },
    P = { "<cmd>Lazy<cr>", "Plugins" },
    p = {
      name = "+Projects",
      p = { "<cmd>Telescope projects<cr>", "Open [P]roject" },
      s = { "<cmd>Telescope live_grep<cr>", "[S]earch in project" },
      f = { "<cmd>Telescope find_files<cr>", "Find [F]ile" },
    },
    s = {
      name = "+Search",
      p = { "<cmd>Telescope live_grep<cr>", "Search in [P]roject" },
      w = { "<cmd>Telescope grep_string<cr>", "Search [W]ord in Project" },
      r = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and [R]eplace" },
    },
    l = {
      name = "+LSP",
      m = { "<cmd>Mason<cr>", "[M]anage LSP" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ctions" },
      l = { "<cmd>TroubleToggle document_diagnostics<cr>", "[L]ist diagnostics" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "List diagnostics [Q]uickfix" },
      d = { "<cmd>TroubleToggle lsp_definitions<cr>", "Show [D]efinitions" },
      t = { "<cmd>TroubleToggle lsp_type_definitions<cr>", "Show [T]ype definitions" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "Show [R]eferences" },
    },
    t = {
      name = "+Test",
      r = { "<cmd>lua require('neotest').run.run()<CR>", "[R]un tests" },
      o = { "<cmd>lua require('neotest').output_panel.toggle()<CR>", "Show tests [O]utput" },
      s = {
        name = "+Summary",
        s = { "<cmd>lua require('neotest').summary.toggle()<CR>", "[S]how summary" },
        r = { "<cmd>lua require('neotest').summary.run_marked()<CR>", "[R]un marked" },
        m = { "<cmd>lua require('neotest').summary.marked()<CR>", "Show [M]arked" },
      }
    },
    v = {
      name = "+Visual",
      c = { "<cmd>Telescope colorscheme<cr>", "Select [C]olorscheme" },
      l = { "<cmd>set background=light<cr>", "Set [L]ight background" },
      d = { "<cmd>set background=dark<cr>", "Set [D]ark background" },
    },
  },
})

wk.register({
  ["<leader>"] = {
    r = {
      name = "+Refactoring",
      r = { "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Select refactoring" },
    },
  },
},
  { mode = "v" })

require('telescope').load_extension('projects')
require('telescope').load_extension('refactoring')
require('telescope').load_extension('ui-select')
require "alpha".setup(require "alpha.themes.dashboard".config)

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.nvim_workspace()
lsp.setup_nvim_cmp({
  completion = {
    keyword_length = 1
  },
  sources = {
    { name = "nvim_lsp", keyword_length = 1 },
    { name = "luasnip",  keyword_length = 1 },
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
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
require('leap').add_default_mappings()
