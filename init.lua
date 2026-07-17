vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.smartindent = true
vim.opt.termguicolors = true
vim.smartindent = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")


vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig.git' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim.git' },

	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim.git' },

	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-context.git' },

	{ src = 'https://github.com/saghen/blink.lib' },
	{ src = 'https://github.com/saghen/blink.cmp' },

	{ src = 'https://github.com/lewis6991/gitsigns.nvim.git' },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua.git' },
	{ src = 'https://github.com/windwp/windline.nvim.git' },

	{ src = 'https://github.com/folke/tokyonight.nvim.git' },
	{ src = 'https://github.com/hedyhli/outline.nvim' }
})

require("core.keymaps")

-- mason
require("mason").setup()
require("mason-lspconfig").setup()

-- blink.cmp
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({ keymap = { preset = 'enter' } })

vim.cmd.colorscheme('tokyonight')

-- gitsigns
require("gitsigns").setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
  end
}

-- nvim-tree
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

-- windline
require('wlsample.bubble2')
require("windline.components.cava").toggle()


-- outline
require("outline").setup({})
vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle outline" })
