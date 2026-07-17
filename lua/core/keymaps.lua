vim.g.mapleader = " ";
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>bo", vim.cmd.NvimTreeFocus)
vim.keymap.set("n", "<leader>bf", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>bx", vim.cmd.NvimTreeClose)

local telescope = require('telescope.builtin')

-- telescope
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'search files' })
vim.keymap.set('n', '<leader>fs', telescope.live_grep, { desc = 'search code' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'search buffers' })

local treesitter_context = require('treesitter-context')

vim.keymap.set("n", "[c", function()
	treesitter_context.go_to_context(vim.v.count1)
end)

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
