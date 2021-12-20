require("plugins")

require("c.keybindings")
require("c.nvim-web-devicons")
require("c.lualine")
require("c.bufferline")
require("c.telescope")
require("c.startify")
require("c.nvim-tree")
require("c.vim-better-whitespace")
require("c.lsp")
require("c.cmp")
require("c.comment")
require("c.autopairs")
require("c.treesitter")
require("c.colors")
--require("c.treesitter-playground") -- Playground is useful when modifying the colorscheme in order to see how TS refers to nodes

-- TODO: Move to it's own general settings file?
local opt = vim.opt

opt.softtabstop = 4                         -- swap existing tab with 4 spaces
opt.shiftwidth = 4                          -- 4 spaces
opt.expandtab = true                        -- on pressing tab, insert 4 spaces
opt.number = true                           -- show line numbers
opt.wrap = false                            -- prevent line wrapping
opt.autoindent = true                       -- enable auto indent
opt.title = true                            -- enable window title (?)
opt.cursorline = true                       -- highlight the current line
opt.scrolloff = 8                           -- Scroll offset (keep an offset on top and bottom when navigating up and down)
opt.textwidth = 0                           -- disable max text width when pasting
opt.mouse = "a"                             -- enable mouse selection
opt.relativenumber = true                   -- relative line numbers
opt.signcolumn = "number"                   -- enable signs in the number column
opt.termguicolors = true                    -- terminal colors (?)
opt.swapfile = false                        -- disable creating swap files
opt.backup = false                          -- if a file is being edited by another program (or it was written from somewhere else) prevent access
opt.undofile = true                         -- enable persistent undo
opt.smartcase = true                        -- when searching ignore case untill you type a capital case (then the search becomes case sensitive)
opt.ignorecase = true                       -- works in conjuction with smartcase
opt.clipboard = "unnamedplus"               -- share clipboard with OS
opt.completeopt = {"menu", "menuone", "noselect" } -- mostly just for cmp

vim.cmd("filetype plugin on") -- allow autocommands to execute when a file matching a pattern is opened
vim.cmd("autocmd FileType * setlocal formatoptions-=cro formatoptions+=t") -- disable auto comment insertion
vim.cmd("autocmd FileType vim,txt setlocal foldmethod=marker") -- ensure that folding works on vim and txt filetypes on the folding marker
