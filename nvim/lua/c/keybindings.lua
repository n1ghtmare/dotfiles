
vim.g.mapleader = " " -- map leader to space
-- Sane split shortcuts
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true})
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true})
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true})
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true})
vim.api.nvim_set_keymap("n", "<leader>`", ":NERDTreeToggle<CR>", { noremap = true})

