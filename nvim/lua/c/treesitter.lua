local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not status_ok then
    return
end

-- TODO: See how we can move the keybindings into the keybindings.lua file?
treesitter.setup({
    -- Languages to be installed with TS -> if more are needed, this is where you install them
    -- For full list of languages: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    -- ensure_installed = {
    --     "lua",
    --     "rust",
    --     "tsx",
    --     "typescript",
    --     "vim",
    --     "c",
    --     "yaml",
    --     "markdown",
    --     "comment",
    --     "bash",
    --     "c_sharp",
    --     "css",
    --     "diff",
    --     "git_config",
    --     "git_rebase",
    --     "gitattributes",
    --     "gitcommit",
    --     "gitignore",
    --     "go",
    --     "html",
    --     "http",
    --     "jsdoc",
    --     "json",
    --     "toml",
    --     "regex",
    --     "prisma",
    --     "sql",
    --     "sxhkdrc",
    --     "javascript",
    -- },
    ensure_installed = "all",
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>"
        }
    },
    textobjects = {
        select = {
            -- When in visual mode and doing a selection
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
})
