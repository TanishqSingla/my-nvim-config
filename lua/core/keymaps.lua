vim.g.mapleader = " ";
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>bo", vim.cmd.NvimTreeFocus)
vim.keymap.set("n", "<leader>bf", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>bx", vim.cmd.NvimTreeClose)
vim.keymap.set("n", "<leader>o", vim.cmd.Outline)
