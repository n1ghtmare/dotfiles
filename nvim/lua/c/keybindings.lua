local opts = { noremap = true, silent = true }
local m = {}

vim.g.mapleader = " " -- map leader to space

-- Sane split shortcuts
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W><C-J>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W><C-K>", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W><C-L>", opts)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-W><C-H>", opts)

-- NvimTree
vim.api.nvim_set_keymap("n", "<leader>`", ":NvimTreeToggle<CR>", opts)                      -- NvimTree toggle <leader>`

-- Telescope
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)                -- Ctrl-p - find files
vim.api.nvim_set_keymap("n", "<C-e>", "<cmd>Telescope live_grep<CR>", opts)                 -- Ctrl-e - search with grep (contents of files)
vim.api.nvim_set_keymap("n", "<C-b>", "<cmd>Telescope buffers<CR>", opts)                   -- Ctrl-b - search current buffers
vim.api.nvim_set_keymap("n", "<C-_>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts) -- Ctrl-/ - search the current buffer with fuzzy find
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)            -- space-fh - search help tags in nvim as well as for all installed plugins
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>Telescope git_files<CR>", opts)            -- space-ft - search for git files only
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>Telescope tagstack<CR>", opts)            -- space-ft - search for git files only


-- LSP
function m.lsp_keybindings_for_buffer(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>Telescope lsp_code_actions<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>Telescope diagnostics<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    --vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

return m;
