local m = {}

local buf_set_keymap = vim.api.nvim_buf_set_keymap

local merge_tables = function(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

local set_keymap = function(mode, key, event, opts)
    local default_opts = { noremap = true, silent = true }
    local result = merge_tables(default_opts, opts)
    vim.api.nvim_set_keymap(mode, key, event, result)
end

-- vim.g.mapleader = " " -- map leader to space

-- Paste without losing yanked content
set_keymap("x", "<leader>p", [["_dP]], {})

-- Basic
set_keymap("n", "_", ":nohl<CR>", { desc = "Clear search results" })

-- Paste to a black hole register so that you can paste multiple times over a visual selection
-- set_keymap("x", "<leader>p", "\"_dP", opts)

-- Move line up and down and set the formatting correctly
set_keymap("n", "<A-j>", ":move .+1<CR>==", {})
set_keymap("n", "<A-k>", ":move .-2<CR>==", {})

-- Move visual selection up and down (including a visual block)
set_keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", {})
set_keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", {})

-- Sane split shortcuts
set_keymap("n", "<C-j>", "<C-W><C-J>", {})
set_keymap("n", "<C-k>", "<C-W><C-K>", {})
set_keymap("n", "<C-l>", "<C-W><C-L>", {})
set_keymap("n", "<C-h>", "<C-W><C-H>", {})

-- MiniFiles (file browser in a floating window)
-- set_keymap("n", "<leader>`", ":lua MiniFiles.open()<CR>", { desc = "Open MiniFiles file browser" }) -- MiniFiles toggle <leader>`
set_keymap("n", "<leader>`", "<cmd>Oil<CR>", { desc = "Open Oil file browser" }) -- MiniFiles toggle <leader>`

-- Whitespace trim
set_keymap("n", "<leader>wt", ":lua MiniTrailspace.trim()<CR>", {})

-- Copilot Ctrl-l to accept the suggestion
set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, script = true })

-- Telescope
set_keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files (telescope) [Ctrl-p]" })
set_keymap(
    "n",
    "<C-e>",
    "<cmd>Telescope live_grep<CR>",
    { desc = "Search with grep (telescope) (contents of files) [Ctrl-e]" }
) -- Ctrl-e - search with grep (contents of files)
set_keymap("n", "<C-b>", "<cmd>Telescope buffers<CR>", { desc = "Find [b]uffers (telescope) [Ctrl-b]" }) -- Ctrl-b - search current buffers
set_keymap(
    "n",
    "<leader>bf",
    "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    { desc = "Search current [b]u[f]fer (telescope)" }
) -- Ctrl-/ - search the current buffer with fuzzy find
set_keymap(
    "n",
    "<leader>ds",
    "<cmd>Telescope lsp_document_symbols<CR>",
    { desc = "Search [d]ocument [s]ymbols (telescope)" }
) -- Ctrl-/ - search the current buffer with fuzzy find
set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "[F]ind [h]elp tag (telescope)" }) -- space-fh - search help tags in nvim as well as for all installed plugins
set_keymap("n", "<leader>ft", "<cmd>Telescope git_files<CR>", {}) -- space-ft - search for git files only
set_keymap("n", "<leader>ts", "<cmd>Telescope tagstack<CR>", {}) -- space-ft - search for git files only
set_keymap("n", "<leader>mk", "<cmd>Telescope marks<CR>", {}) -- space-ft - search for git files only

-- undotree
set_keymap("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", {})

-- Better vertical movements
set_keymap("n", "<C-d>", "<C-d>zz", {})
set_keymap("n", "<C-u>", "<C-u>zz", {})

-- Better search jumps
set_keymap("n", "n", "nzzzv", {})
set_keymap("n", "N", "Nzzzv", {})

-- Todo Comments
set_keymap("n", "<leader>td", "<cmd>TodoQuickFix<CR>", {})

-- LSP
function m.lsp_keybindings_for_buffer(bufnr)
    buf_set_keymap(bufnr, "n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", {})
    -- buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", {})
    -- buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>st", "<cmd>Telescope git_status<CR>", {})
    -- buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", {})
    -- buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>Telescope lsp_code_actions<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
    buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
    buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>Telescope diagnostics<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", {})
    -- buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", {})
    --vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

return m
