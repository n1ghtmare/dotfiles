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
set_keymap("n", "<leader>`", ":lua MiniFiles.open()<CR>", { desc = "Open MiniFiles file browser" }) -- MiniFiles toggle <leader>`

-- Whitespace trim
set_keymap("n", "<leader>wt", ":lua MiniTrailspace.trim()<CR>", {})

-- Copilot Ctrl-l to accept the suggestion
set_keymap("i", "<C-l>", "copilot#Accept(\"<CR>\")", { expr = true, script = true })

-- FFF file picker
set_keymap("n", "<C-p>", "<cmd>FFFFind<CR>", { desc = "Find files [Ctrl-p]" })

-- Mini Pick
-- set_keymap("n", "<C-p>", "<cmd>Pick files<CR>", { desc = "Find files [Ctrl-p]" })
set_keymap("n", "<C-e>", "<cmd>Pick grep_live<CR>", { desc = "Search with grep (contents of files) [Ctrl-e]" })
-- set_keymap("n", "<C-b>", "<cmd>Pick buffers<CR>", { desc = "Find [b]uffers [Ctrl-b]" })
set_keymap("n", "<C-b>", "<cmd>Pick my_buffers<CR>", { desc = "Find [b]uffers [Ctrl-b]" })
set_keymap("n", "<leader>ds", "<cmd>Pick lsp scope='document_symbol'<CR>", { desc = "Search [d]ocument [s]ymbols" })
set_keymap("n", "<leader>hp", "<cmd>Pick help<CR>", { desc = "Search [h]el[p]" })
set_keymap("n", "<leader>mk", "<cmd>Pick marks<CR>", { desc = "Search [m]ar[k]s" })

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

-- A global function to toggle LSP inlay hints for the provided buffer number
-- This is used with the keybinding below
function LspInlayHintsToggle(bufnr)
    local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
    vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
end

-- LSP
function m.lsp_keybindings_for_buffer(bufnr)
    buf_set_keymap(bufnr, "n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>Pick lsp scope='definition'<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", {})

    buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>Pick lsp scope='implementation'<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>Pick lsp scope='references'<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
    buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
    buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>Pick diagnostic<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", {})

    -- Toggle Inlay Hints
    buf_set_keymap(bufnr, "n", "<leader>ih", "<cmd>lua LspInlayHintsToggle(" .. bufnr .. ")<CR>", {
        desc = "Toggle LSP Inlay Hints",
    })
end

return m
