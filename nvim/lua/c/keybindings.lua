
vim.g.mapleader = " " -- map leader to space
-- Sane split shortcuts
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true})
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true})
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true})
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true})

-- NERDTree toggle <leader>`
--vim.api.nvim_set_keymap("n", "<leader>`", ":NERDTreeToggle<CR>", { noremap = true})
vim.api.nvim_set_keymap("n", "<leader>`", ":NvimTreeToggle<CR>", { noremap = true})

-- Telescope
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", { noremap = true })      -- Ctrl-p - find files
vim.api.nvim_set_keymap("n", "<C-e>", "<cmd>Telescope live_grep<CR>", { noremap = true })       -- Ctrl-e - search with grep (contents of files)
vim.api.nvim_set_keymap("n", "<C-b>", "<cmd>Telescope buffers<CR>", { noremap = true })         -- Ctrl-b - search current buffers
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { noremap = true })  -- space-fh - search help tags in nvim as well as for all installed plugins
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>Telescope git_files<CR>", { noremap = true })  -- space-ft - search for git files only
