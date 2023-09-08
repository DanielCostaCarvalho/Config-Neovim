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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menuone,noinsert,noselect"

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
  'nvim-lua/plenary.nvim',
  { 'ahmedkhalf/project.nvim',       config = {},  name = 'project_nvim' }, -- manage projects
  { 'ThePrimeagen/refactoring.nvim', config = true },                       -- auto refactoring

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-telescope/telescope-ui-select.nvim',

  -- Visual
  'nvim-treesitter/nvim-treesitter',
  {
    'nvim-lualine/lualine.nvim',
    config = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  { 'NLKNguyen/papercolor-theme', lazy = false },

  -- File Navigation
  { "ThePrimeagen/harpoon",       dependencies = "nvim-lua/plenary.nvim", config = true },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
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

  -- Git 	
  { "NeogitOrg/neogit",      dependencies = "nvim-lua/plenary.nvim", config = true },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 4000,
        ignore_whitespace = false,
      },
    }
  },

  -- HTTP requests
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      jump_to_request = true,
    }
  },

  -- lsp
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'VonHeikemen/lsp-zero.nvim',
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function()
      local null_ls = require("null-ls");
      return {
        sources = {
          null_ls.builtins.diagnostics.cspell.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity["WARN"]
            end,
          }),
          null_ls.builtins.code_actions.cspell,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.formatting.rome,
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
                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
              end,
            })
          end
        end,
      }
    end
  },
  --
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
      },
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
      p = { "<cmd>NvimTreeToggle<cr>", "[P]roject sidebar" },
      t = { "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", "[T]erminal" },
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
    h = {
      name = "+Harpoon",
      a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "[A]dd file" },
      m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle [M]enu" },
      h = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Navigate to prev" },
      l = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Navigate to next" },
      n = {
        name = "+Navigate",
        q = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to 1" },
        w = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to 2" },
        e = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to 3" },
        r = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to 4" },
        t = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Navigate to 5" },
        y = { "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "Navigate to 6" },
        u = { "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", "Navigate to 7" },
        i = { "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", "Navigate to 8" },
        o = { "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", "Navigate to 9" },
        p = { "<cmd>lua require('harpoon.ui').nav_file(10)<cr>", "Navigate to 10" },
      },
      s = { "<cmd>Telescope harpoon marks<cr>", "[S]how marks" },
      t = {
        name = "+Terminal",
        q = { "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", "Open Terminal 1" },
        w = { "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>", "Open Terminal 2" },
        e = { "<cmd>lua require('harpoon.term').gotoTerminal(3)<cr>", "Open Terminal 3" },
        r = { "<cmd>lua require('harpoon.term').gotoTerminal(4)<cr>", "Open Terminal 4" },
        t = { "<cmd>lua require('harpoon.term').gotoTerminal(5)<cr>", "Open Terminal 5" },
        y = { "<cmd>lua require('harpoon.term').gotoTerminal(6)<cr>", "Open Terminal 6" },
        u = { "<cmd>lua require('harpoon.term').gotoTerminal(7)<cr>", "Open Terminal 7" },
        i = { "<cmd>lua require('harpoon.term').gotoTerminal(8)<cr>", "Open Terminal 8" },
        o = { "<cmd>lua require('harpoon.term').gotoTerminal(9)<cr>", "Open Terminal 9" },
        p = { "<cmd>lua require('harpoon.term').gotoTerminal(10)<cr>", "Open Terminal 10" },
      },
    },
    l = {
      name = "+LSP",
      m = { "<cmd>Mason<cr>", "[M]anage LSP" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ctions" },
      r = { "<cmd>Telescope lsp_references<cr>", "Show [R]eferences" },
      i = { "<cmd>Telescope lsp_implementations<cr>", "Show [I]mplementation" },
      f = { "<cmd>lua vim.lsp.buf.format()<cr>", "[F]ormat code" },
      c = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[C]hange name" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[S]ignature help" },
      d = { "<cmd>Telescope diagnostics<cr>", "Show [D]iagnostics" },
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
require("telescope").load_extension('harpoon')

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
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.default_keymaps({
  buffer = bufnr,
  preserve_mappings = false
})

lsp.setup()

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = true
})
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float()
  end
})
