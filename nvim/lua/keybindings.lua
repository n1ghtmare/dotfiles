local m = {}

-- vim.g.mapleader = " " -- map leader to space

-- Paste without losing yanked content
vim.keymap.set("x", "<leader>p", [["_dP]], { silent = true })

-- Basic
vim.keymap.set("n", "_", ":nohl<CR>", { silent = true, desc = "Clear search results" })

-- Move line up and down and set the formatting correctly
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==", { silent = true })

-- Move visual selection up and down (including a visual block)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", { silent = true })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", { silent = true })

-- Sane split shortcuts
vim.keymap.set("n", "<C-j>", "<C-W><C-J>", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-W><C-K>", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-W><C-L>", { silent = true })
vim.keymap.set("n", "<C-h>", "<C-W><C-H>", { silent = true })

-- MiniFiles (file browser in a floating window)
vim.keymap.set("n", "<leader>`", ":lua MiniFiles.open()<CR>", { silent = true, desc = "Open MiniFiles file browser" }) -- MiniFiles toggle <leader>`

-- Whitespace trim
vim.keymap.set("n", "<leader>wt", ":lua MiniTrailspace.trim()<CR>", { silent = true })

-- Copilot Ctrl-l to accept the suggestion
vim.keymap.set("i", "<C-l>", "copilot#Accept(\"<CR>\")", { expr = true, script = true, silent = true })

-- Mini Pick
-- vim.keymap.set("n", "<C-p>", "<cmd>Pick files<CR>", { desc = "Find files [Ctrl-p]" })
-- vim.keymap.set("n", "<C-p>", "<cmd>Pick fffiles<CR>", { desc = "Find files [Ctrl-p]" })
vim.keymap.set("n", "<C-p>", ":lua require('fff').find_files()<CR>", { silent = true, desc = "Find files [Ctrl-p]" })
vim.keymap.set(
    "n",
    "<C-e>",
    ":lua require('fff').live_grep()<CR>",
    { silent = true, desc = "Search with grep (contents of files) [Ctrl-e]" }
)
-- vim.keymap.set("n", "<C-e>", "<cmd>Pick grep_live<CR>", { desc = "Search with grep (contents of files) [Ctrl-e]" })
-- vim.keymap.set("n", "<C-b>", "<cmd>Pick buffers<CR>", { desc = "Find [b]uffers [Ctrl-b]" })
vim.keymap.set("n", "<C-b>", "<cmd>Pick my_buffers<CR>", { silent = true, desc = "Find [b]uffers [Ctrl-b]" })
vim.keymap.set("n", "<leader>ds", "<cmd>Pick lsp scope='document_symbol'<CR>", { silent = true, desc = "Search [d]ocument [s]ymbols" })
vim.keymap.set("n", "<leader>hp", "<cmd>Pick help<CR>", { silent = true, desc = "Search [h]el[p]" })
vim.keymap.set("n", "<leader>mk", "<cmd>Pick marks<CR>", { silent = true, desc = "Search [m]ar[k]s" })

-- undotree
vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", { silent = true })

-- Better vertical movements
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

-- Better search jumps
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

-- Todo Comments
vim.keymap.set("n", "<leader>td", "<cmd>TodoQuickFix<CR>", { silent = true })

-- Copy file path to clipboard
vim.keymap.set("n", "<leader>cfp", ":lua CopyCurrentFilePath()<CR>", { silent = true, desc = "Copy current file path to clipboard" })

-- Treesitter incremental selection
vim.keymap.set("n", "<A-o>", "van", { remap = true, desc = "Init treesitter selection" })
vim.keymap.set("x", "<A-o>", "an", { remap = true, desc = "Increment treesitter selection" })
vim.keymap.set("x", "<A-i>", "in", { remap = true, desc = "Decrement treesitter selection" })

-- Treesitter textobjects
local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
local swap = require("nvim-treesitter-textobjects.swap")
local move = require("nvim-treesitter-textobjects.move")

-- Select keymaps (visual + operator-pending)
--
-- In normal mode, `caa` (change around argument) or `vaa` (to visually
-- select around argument)
vim.keymap.set({ "x", "o" }, "aa", function()
    select_textobject("@parameter.outer", "textobjects")
end)
-- In normal mode, `cia` (change inside argument) or `via` (to visually
-- select inside argument)
vim.keymap.set({ "x", "o" }, "ia", function()
    select_textobject("@parameter.inner", "textobjects")
end)
-- In normal mode, `caf` (change around function) or `vaf` (to visually
-- select around function)
vim.keymap.set({ "x", "o" }, "af", function()
    select_textobject("@function.outer", "textobjects")
end)
-- In normal mode, `cif` (change inside function) or `vif` (to visually
-- select inside function)
vim.keymap.set({ "x", "o" }, "if", function()
    select_textobject("@function.inner", "textobjects")
end)
-- In normal mode, `cac` (change around class) or `vac` (to visually
-- select around class)
vim.keymap.set({ "x", "o" }, "ac", function()
    select_textobject("@class.outer", "textobjects")
end)
-- In normal mode, `cic` (change inside class) or `vic` (to visually
-- select inside class)
vim.keymap.set({ "x", "o" }, "ic", function()
    select_textobject("@class.inner", "textobjects")
end)

-- Move keymaps (normal + visual + operator-pending)
--
-- Jump to the next start of a function with `]m`, next class with
-- `]]`, end of function with `]M`, and end of class with `][`.
--
-- Similarly, you can go to the previous start of a function with `[m`,
-- previous class with `[[`, and previous end of a function or class
-- with `[M` and `[]`, respectively.
vim.keymap.set({ "n", "x", "o" }, "]m", function()
    move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
    move.goto_next_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]M", function()
    move.goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
    move.goto_next_end("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
    move.goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
    move.goto_previous_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[M", function()
    move.goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
    move.goto_previous_end("@class.outer", "textobjects")
end)

-- Swap keymaps (normal)
vim.keymap.set("n", "<leader>a", function()
    swap.swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>A", function()
    swap.swap_previous("@parameter.inner")
end)

-- A global function to toggle LSP inlay hints for the provided buffer number
-- This is used with the keybinding below
function LspInlayHintsToggle(bufnr)
    local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
    vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
end

-- Copy the current file path to the clipboard
function CopyCurrentFilePath()
    local file_path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg("+", file_path)
    print("Copied file path: " .. file_path)
end

-- LSP
function m.lsp_keybindings_for_buffer(bufnr)
    vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>gd", "<cmd>Pick lsp scope='definition'<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set(
        "n",
        "<leader>k",
        "<cmd>lua vim.lsp.buf.hover({ max_width = 110, border = 'single' })<CR>",
        { buffer = bufnr, silent = true }
    )
    vim.keymap.set("n", "<leader>gi", "<cmd>Pick lsp scope='implementation'<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>gr", "<cmd>Pick lsp scope='references'<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>q", "<cmd>Pick diagnostic<CR>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>ff", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", { buffer = bufnr, silent = true })

    -- Toggle Inlay Hints
    vim.keymap.set("n", "<leader>ih", "<cmd>lua LspInlayHintsToggle(" .. bufnr .. ")<CR>", {
        buffer = bufnr,
        silent = true,
        desc = "Toggle LSP Inlay Hints",
    })
end

return m
