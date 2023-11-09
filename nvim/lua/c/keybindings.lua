local opts = { noremap = true, silent = true }
local m = {}

local set_keymap = vim.api.nvim_set_keymap
local buf_set_keymap = vim.api.nvim_buf_set_keymap

vim.g.mapleader = " " -- map leader to space

-- Paste without losing yanked content
set_keymap("x", "<leader>p", [["_dP]], opts)

-- Basic
-- Clear search results by pressing _
set_keymap("n", "_", ":nohl<CR>", opts);

-- Paste to a black hole register so that you can paste multiple times over a visual selection
-- set_keymap("x", "<leader>p", "\"_dP", opts)

-- Move lines up and down
-- Move line up and down and set the formatting correctly
set_keymap("n", "<A-j>", ":move .+1<CR>==", opts)
set_keymap("n", "<A-k>", ":move .-2<CR>==", opts)
-- Move visual selection up and down (including a visual block)
set_keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
set_keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Sane split shortcuts
set_keymap("n", "<C-j>", "<C-W><C-J>", opts)
set_keymap("n", "<C-k>", "<C-W><C-K>", opts)
set_keymap("n", "<C-l>", "<C-W><C-L>", opts)
set_keymap("n", "<C-h>", "<C-W><C-H>", opts)

-- NvimTree
set_keymap("n", "<leader>`", ":NvimTreeToggle<CR>", opts) -- NvimTree toggle <leader>`
-- set_keymap("n", "<leader>`", "<cmd>Telescope file_browser<CR>", opts)                      -- NvimTree toggle <leader>`

-- Copilot Ctrl-l to accept the suggestion
set_keymap('i', '<C-l>', 'copilot#Accept("<CR>")', {expr = true, silent = true, script = true, noremap = true})

-- Telescope
set_keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts) -- Ctrl-p - find files
set_keymap("n", "<C-e>", "<cmd>Telescope live_grep<CR>", opts) -- Ctrl-e - search with grep (contents of files)
set_keymap("n", "<C-b>", "<cmd>Telescope buffers<CR>", opts) -- Ctrl-b - search current buffers
set_keymap("n", "<leader>bf", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts) -- Ctrl-/ - search the current buffer with fuzzy find
set_keymap("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", opts) -- Ctrl-/ - search the current buffer with fuzzy find
set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts) -- space-fh - search help tags in nvim as well as for all installed plugins
set_keymap("n", "<leader>ft", "<cmd>Telescope git_files<CR>", opts) -- space-ft - search for git files only
set_keymap("n", "<leader>ts", "<cmd>Telescope tagstack<CR>", opts) -- space-ft - search for git files only
set_keymap("n", "<leader>mk", "<cmd>Telescope marks<CR>", opts) -- space-ft - search for git files only

-- undotree
set_keymap("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", opts)

-- Better vertical movements
set_keymap("n", "<C-d>", "<C-d>zz", opts)
set_keymap("n", "<C-u>", "<C-u>zz", opts)

-- Better search jumps
set_keymap("n", "n", "nzzzv", opts)
set_keymap("n", "N", "Nzzzv", opts)

-- Todo Comments
set_keymap("n", "<leader>td", "<cmd>TodoQuickFix<CR>", opts)

-- LSP
function m.lsp_keybindings_for_buffer(bufnr)
    buf_set_keymap(bufnr, "n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    -- buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    -- buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>st", "<cmd>Telescope git_status<CR>", opts)
    -- buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>Telescope lsp_code_actions<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>Telescope diagnostics<CR>", opts)
    buf_set_keymap(bufnr, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
    -- buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    --vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

return m;
