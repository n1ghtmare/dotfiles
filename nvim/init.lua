require("plugins")

require("c.keybindings")
require("c.colors")
require("c.telescope")
require("c.lsp")
require("c.cmp")
require("c.treesitter")
require("c.nvim-web-devicons")
require("c.lualine")
require("c.luasnip")
require("c.todo-comments")
require("c.project")
require("c.fidget")
require("c.mini")
require("c.copilot")
require("c.autopairs")
require("c.comment")
require("c.which-key")
require("c.trouble")

-- require("c.treesitter-playground") -- Playground is useful when modifying the colorscheme in order to see how TS refers to nodes
-- require("colorbuddy").colorscheme("noirbuddy")

-- TODO: Move to it's own general settings file?
local opt = vim.opt

opt.softtabstop = 4                                 -- swap existing tab with 4 spaces
opt.shiftwidth = 4                                  -- 4 spaces
opt.expandtab = true                                -- on pressing tab, insert 4 spaces
opt.number = true                                   -- show line numbers
opt.wrap = false                                    -- prevent line wrapping
opt.autoindent = true                               -- enable auto indent
opt.title = true                                    -- enable window title (?)
opt.cursorline = true                               -- highlight the current line
-- opt.scrolloff = 8 -- Scroll offset (keep an offset on top and bottom when navigating up and down)
opt.textwidth = 0                                   -- disable max text width when pasting
opt.mouse = "a"                                     -- enable mouse selection
opt.relativenumber = true                           -- relative line numbers
-- opt.signcolumn = "number" -- enable signs in the number column
opt.signcolumn = "yes:1"                            -- keep both the signs and the numbers in separate columns
opt.termguicolors = true                            -- terminal colors (?)
opt.swapfile = false                                -- disable creating swap files
opt.backup = false                                  -- if a file is being edited by another program (or it was written from somewhere else) prevent access (file path on arch is .local/state/nvim/undo/)
opt.undofile = true                                 -- enable persistent undo
opt.smartcase = true                                -- when searching ignore case untill you type a capital case (then the search becomes case sensitive)
opt.ignorecase = true                               -- works in conjuction with smartcase
opt.clipboard = "unnamedplus"                       -- share clipboard with OS
opt.splitright = true                               -- force all vertical splits to go to the right of the current buffer
opt.splitbelow = true                               -- force all horizontal splits to go below the current buffer
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
-- opt.cmdheight = 0                                          -- hide the command line on the bottom
-- opt.ch = 0 -- hide the command line on the bottom
opt.backupcopy = "yes" -- different strategy of how backups are stored and copied (was having issues with file watchers detecting changes to the file before this setting) run :help backupcopy TODO: See if we can remove this - keep a look at https://github.com/tailwindlabs/tailwindcss/issues/7759
-- opt.ls = 0 -- hide the status line on the bottom
-- opt.shortmess = "nocI" -- fixes a bug that when ch = 0, then searching for a file and opening is displaying a "Press ENTER to continue" message

-- different strategy of how backups are stored and copied (was having issues with file watchers detecting changes to the file before this setting) run :help backupcopy TODO: See if we can remove this - keep a look at https://github.com/tailwindlabs/tailwindcss/issues/7759
opt.backupcopy = "yes"

vim.cmd("filetype plugin on")                                              -- allow autocommands to execute when a file matching a pattern is opened
vim.cmd("autocmd FileType * setlocal formatoptions-=cro formatoptions-=t") -- disable auto comment insertion
vim.cmd("autocmd FileType vim,txt setlocal foldmethod=marker")             -- ensure that folding works on vim and txt filetypes on the folding marker


-- when setting the cmdheight/ch=0, recording a macro doesn't display the message
-- this will auto set the cmd height to 1 when recording a marco
-- vim.cmd("autocmd RecordingEnter * set cmdheight=1")
-- vim.cmd("autocmd RecordingLeave * set cmdheight=0")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function(_)
        vim.highlight.on_yank({ higroup = "DiffAdd", timeout = 150 })
    end,
})

-- Set a better title
local title = vim.fn.getcwd():gsub("^.*/", "")
opt.titlestring = string.format("nvim - %s", title)
