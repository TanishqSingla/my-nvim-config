require("lazy").setup({
	"rebelot/kanagawa.nvim",
	"nvim-treesitter/nvim-treesitter",
	"nvim-lualine/lualine.nvim",
	{ "nvim-tree/nvim-tree.lua",       dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	"lewis6991/gitsigns.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	{ "williamboman/mason-lspconfig.nvim", version = "1.32.0" },
	{ "williamboman/mason.nvim", version = "1.11.0" } ,
	"nvim-treesitter/nvim-treesitter-context",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"neanias/everforest-nvim",
	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		lazy = true,
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
})
