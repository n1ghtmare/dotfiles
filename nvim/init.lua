local opt = vim.opt

opt.softtabstop = 4 -- swap existing tab with 4 spaces
opt.shiftwidth = 4 -- 4 spaces
opt.expandtab = true -- on pressing tab, insert 4 spaces
opt.number = true -- show line numbers
opt.wrap = false -- prevent line wrapping
opt.autoindent = true -- enable auto indent
opt.title = true -- enable window title (?)
opt.cursorline = true -- highlight the current line
-- opt.scrolloff = 8 -- Scroll offset (keep an offset on top and bottom when navigating up and down)
opt.textwidth = 0 -- disable max text width when pasting
opt.mouse = "a" -- enable mouse selection
opt.relativenumber = true -- relative line numbers
-- opt.signcolumn = "number" -- enable signs in the number column
opt.signcolumn = "yes:1" -- keep both the signs and the numbers in separate columns
opt.termguicolors = true -- terminal colors (?)
opt.swapfile = false -- disable creating swap files
opt.backup = false -- if a file is being edited by another program (or it was written from somewhere else) prevent access (file path on arch is .local/state/nvim/undo/)
opt.undofile = true -- enable persistent undo
opt.smartcase = true -- when searching ignore case untill you type a capital case (then the search becomes case sensitive)
opt.ignorecase = true -- works in conjuction with smartcase
opt.clipboard = "unnamedplus" -- share clipboard with OS
opt.splitright = true -- force all vertical splits to go to the right of the current buffer
opt.splitbelow = true -- force all horizontal splits to go below the current buffer
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
-- opt.cmdheight = 0                                          -- hide the command line on the bottom
-- opt.ch = 0 -- hide the command line on the bottom
opt.backupcopy = "yes" -- different strategy of how backups are stored and copied (was having issues with file watchers detecting changes to the file before this setting) run :help backupcopy TODO: See if we can remove this - keep a look at https://github.com/tailwindlabs/tailwindcss/issues/7759
-- opt.ls = 0 -- hide the status line on the bottom
-- opt.shortmess = "nocI" -- fixes a bug that when ch = 0, then searching for a file and opening is displaying a "Press ENTER to continue" message

-- different strategy of how backups are stored and copied (was having issues with file watchers detecting changes to the file before this setting) run :help backupcopy TODO: See if we can remove this - keep a look at https://github.com/tailwindlabs/tailwindcss/issues/7759
opt.backupcopy = "yes"

vim.g.mapleader = " " -- map leader to space

vim.cmd("filetype plugin on") -- allow autocommands to execute when a file matching a pattern is opened
vim.cmd("autocmd FileType * setlocal formatoptions-=cro formatoptions-=t") -- disable auto comment insertion
vim.cmd("autocmd FileType vim,txt setlocal foldmethod=marker") -- ensure that folding works on vim and txt filetypes on the folding marker

-- when setting the cmdheight/ch=0, recording a macro doesn't display the message
-- this will auto set the cmd height to 1 when recording a marco
-- vim.cmd("autocmd RecordingEnter * set cmdheight=1")
-- vim.cmd("autocmd RecordingLeave * set cmdheight=0")

-- Highlight 121st character on lines that exceed 120
vim.fn.matchadd("ColorColumn", "\\%121v")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function(_)
        vim.highlight.on_yank({ higroup = "DiagnosticWarn", timeout = 150 })
    end,
})

-- Set a better title
local title = vim.fn.getcwd():gsub("^.*/", "")
opt.titlestring = string.format("nvim - %s", title)

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins via Lazy
require("lazy").setup({
    spec = {
        -- Import all plugins from the plugins directory
        import = "plugins",
    },
})

-- Load LSP settings
require("lsp")

-- Load keybindings
require("keybindings")
