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

--vim.opt.foldmethod = "indent"
--vim.opt.foldlevel = 1

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
	"nvim-lua/plenary.nvim",
	{ "ahmedkhalf/project.nvim", config = true, name = "project_nvim" }, -- manage projects

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"nvim-telescope/telescope-ui-select.nvim",

	-- Visual
	"nvim-treesitter/nvim-treesitter",
	{
		"nvim-lualine/lualine.nvim",
		config = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	{ "NLKNguyen/papercolor-theme", lazy = false },

	-- File Navigation
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = "nvim-lua/plenary.nvim",
		config = {
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
			terms = {
				settings = {
					save_on_toggle = false,
					select_with_nil = false,
					sync_on_ui_close = false,
				},
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			view = {
			  side = 'right',
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
		},
	},
	{
		"ggandor/leap.nvim",
		dependencies = "tpope/vim-repeat",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	-- Git
	{ "NeogitOrg/neogit", dependencies = "nvim-lua/plenary.nvim", config = true },
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 4000,
				ignore_whitespace = false,
			},
		},
	},

	--HTTP requests
	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function ()
		  require("rest-nvim").setup({
        jump_to_request = true,
		  })
		end,
	},

	-- lsp
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{
		"nvimtools/none-ls.nvim",
		opts = function()
			local null_ls = require("null-ls")
			local h = require("null-ls.helpers")
			local u = require("null-ls.utils")

			return {
				sources = {
					null_ls.builtins.diagnostics.cspell.with({
						diagnostics_postprocess = function(diagnostic)
							diagnostic.severity = vim.diagnostic.severity["WARN"]
						end,
					}),
					null_ls.builtins.code_actions.cspell,
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.formatting.biome,
					null_ls.builtins.formatting.biome,
					null_ls.builtins.formatting.eslint_d,
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.formatting.pint,
					null_ls.builtins.diagnostics.phpstan,
					null_ls.builtins.formatting.blade_formatter,
					null_ls.builtins.formatting.stylua,
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
								vim.lsp.buf.format({
									bufnr = bufnr,
									timeout_ms = 3000,
									filter = function(client)
										return client.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
				temp_dir = "/tmp",
			}
		end,
	},
	--
	-- autocomplete
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"saadparwaiz1/cmp_luasnip",
	{ "windwp/nvim-autopairs", config = true },

	-- snippets
	"rafamadriz/friendly-snippets",
	"L3MON4D3/LuaSnip",

	-- key bindings
	{ "folke/which-key.nvim", config = true },
})

vim.cmd.colorscheme("PaperColor")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local harpoon = require("harpoon")

---@type HarpoonList
local term_list = harpoon:list("terms")

---@return string name of the created terminal
local function create_terminal()
	vim.cmd("terminal")
	local buf_id = vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(buf_id)
end

---@param index number: The index of the terminal to select.
local function select_term(index)
	if index > term_list:length() then
		create_terminal()
		print("Creating terminal", index)
		-- just append the newly open terminal
		term_list:append()
	else
		-- find in list
		print("selecting terminal", index)
		term_list:select(index)
	end
end

-- Autocommand to remove closed terminal from the list
vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	callback = function(_)
		for _, term in ipairs(term_list.items) do
			local bufnr = vim.fn.bufnr(term.value)
			if bufnr == -1 then
				print("Removing:" .. term.value)
				term_list:remove(term)
			end
		end
	end,
})

local wk = require("which-key")

wk.register({
	["<leader>"] = {
		["<leader>"] = {
			"<cmd>Telescope find_files<cr>",
			"Find File",
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
			t = {
				function()
					select_term(1)
				end,
				"[T]erminal",
			},
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
		r = {
			name = "+Rest",
			r = { "<Plug>RestNvim", "[R]un request" },
			p = { "<Plug>RestNvimPreview", "[P]preview request" },
			l = { "<Plug>RestNvimLast", "run [L]ast request" },
		},
		s = {
			name = "+Search",
			p = { "<cmd>Telescope live_grep<cr>", "Search in [P]roject" },
			w = { "<cmd>Telescope grep_string<cr>", "Search [W]ord in Project" },
			r = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and [R]eplace" },
		},
		h = {
			name = "+Harpoon",
			a = {
				function()
					harpoon:list():append()
				end,
				"[A]dd file",
			},
			m = {
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				"Toggle [M]enu",
			},
			h = {
				function()
					harpoon:list():prev()
				end,
				"Navigate to prev",
			},
			l = {
				function()
					harpoon:list():next()
				end,
				"Navigate to next",
			},
			n = {
				name = "+Navigate",
				q = {
					function()
						harpoon:list():select(1)
					end,
					"Navigate to 1",
				},
				w = {
					function()
						harpoon:list():select(2)
					end,
					"Navigate to 2",
				},
				e = {
					function()
						harpoon:list():select(3)
					end,
					"Navigate to 3",
				},
				r = {
					function()
						harpoon:list():select(4)
					end,
					"Navigate to 4",
				},
				t = {
					function()
						harpoon:list():select(5)
					end,
					"Navigate to 5",
				},
				y = {
					function()
						harpoon:list():select(6)
					end,
					"Navigate to 6",
				},
				u = {
					function()
						harpoon:list():select(7)
					end,
					"Navigate to 7",
				},
				i = {
					function()
						harpoon:list():select(8)
					end,
					"Navigate to 8",
				},
				o = {
					function()
						harpoon:list():select(9)
					end,
					"Navigate to 9",
				},
				p = {
					function()
						harpoon:list():select(10)
					end,
					"Navigate to 10",
				},
			},
			s = { "<cmd>Telescope harpoon marks<cr>", "[S]how marks" },
			t = {
				name = "+Terminal",
				m = {
					function()
						harpoon.ui:toggle_quick_menu(harpoon:list("terms"))
					end,
					"Toggle [M]enu",
				},
				q = {
					function()
						select_term(1)
					end,
					"Open Terminal 1",
				},
				w = {
					function()
						select_term(2)
					end,
					"Open Terminal 2",
				},
				e = {
					function()
						select_term(3)
					end,
					"Open Terminal 3",
				},
				r = {
					function()
						select_term(4)
					end,
					"Open Terminal 4",
				},
				t = {
					function()
						select_term(5)
					end,
					"Open Terminal 5",
				},
				y = {
					function()
						select_term(6)
					end,
					"Open Terminal 6",
				},
				u = {
					function()
						select_term(7)
					end,
					"Open Terminal 7",
				},
				i = {
					function()
						select_term(8)
					end,
					"Open Terminal 8",
				},
				o = {
					function()
						select_term(9)
					end,
					"Open Terminal 9",
				},
				p = {
					function()
						select_term(10)
					end,
					"Open Terminal 10",
				},
			},
		},
		l = {
			name = "+LSP",
			m = { "<cmd>Mason<cr>", "[M]anage LSP" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ctions" },
			r = { "<cmd>Telescope lsp_references<cr>", "Show [R]eferences" },
			i = { "<cmd>Telescope lsp_implementations<cr>", "Show [I]mplementation" },
			f = {
				function()
					vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 15000 })
				end,
				"[F]ormat code",
			},
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

require("telescope").load_extension("projects")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("harpoon")

local lsp = require("lsp-zero").preset({})
lsp.extend_lspconfig()

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({
		buffer = bufnr,
		preserve_mappings = false,
	})
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		lsp.default_setup,
	},
})

local cmp = require("cmp")
local cmp_format = lsp.cmp_format()
local cmp_action = lsp.cmp_action()
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	formatting = cmp_format,
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	completion = {
		keyword_length = 1,
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "luasnip", keyword_length = 1 },
		{ name = "buffer", keyword_length = 1 },
	},
})

lsp.setup()

vim.diagnostic.config({
	virtual_lines = true,
	virtual_text = true,
})
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float()
	end,
})
