-- colors
local get_background = (function()
	local time = os.date("*t")

	if time.hour >= 18 or time.hour <= 6 then
		vim.o.background = "dark"
		return "kanagawa-dragon"
	end

	vim.o.background = "light"
	return "kanagawa-lotus"
end)

vim.cmd([[colorscheme ]] .. get_background())

-- treesitter
require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "c", "javascript", "typescript", "lua", "vim", "rust" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	-- ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.keymap.set("n", "<leader>bo", vim.cmd.NvimTreeFocus)
vim.keymap.set("n", "<leader>bf", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>bx", vim.cmd.NvimTreeClose)

-- telescope
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fs', telescope.live_grep, {})

-- lualine
require("lualine").setup()

-- gitsigns
require("gitsigns").setup()

-- mason
require("mason").setup()
require("mason-lspconfig").setup()

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', 'ff', function() vim.lsp.buf.format { async = true } end, bufopts)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_flags = {
	debounce_text_changes = 150,
}


require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.


	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities,
			lsp_flags = lsp_flags
		}
	end,
	["ts_ls"] = function()
		require("lspconfig").ts_ls.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			lsp_flags = lsp_flags,
			autostart = not vim.uv.fs_stat("deno.json") 
		}
	end,
	["denols"] = function()
		require("lspconfig").denols.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			lsp_flags = lsp_flags,
			autostart = not not vim.uv.fs_stat("deno.json")
		}
	end
}

-- lsp
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local cmp = require 'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lua' },
			{ name = 'luasnip' }
		},
		{
			{ name = "buffer" },
		}
	),
})

-- nvim-treesitter-context

local treesitter_context = require("treesitter-context")
treesitter_context.setup()

vim.keymap.set("n", "[c", function()
	treesitter_context.go_to_context(vim.v.count1)
end)

-- toggleterm
require("toggleterm").setup {
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	direction = 'float',
	close_on_exit = true,
	shell = vim.o.shell,
	auto_scroll = true,
	float_opts = {
		border = 'curved',
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal"
		}
	},
}
