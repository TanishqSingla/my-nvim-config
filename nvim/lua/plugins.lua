vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(user)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use 'kyazdani42/nvim-web-devicons'

  use 'folke/tokyonight.nvim'

  use {'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }

  use {
    "akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
    end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
   -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'lewis6991/gitsigns.nvim'

  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use "hrsh7th/cmp-nvim-lua"
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }

  use "williamboman/mason-lspconfig.nvim"
end)
