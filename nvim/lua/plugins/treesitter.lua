return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    config = function()
        require("treesitter-context").setup { enable = true }
        require("nvim-treesitter.configs").setup {
            -- Languages to be installed with TS -> if more are needed, this is where you install them
            -- For full list of languages: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
            -- TODO: Clean this list a bit
            ensure_installed = {
                "bash",
                "c",
                "c_sharp",
                "cmake",
                "comment",
                "commonlisp",
                "cpp",
                "css",
                "d",
                "diff",
                "dockerfile",
                "elixir",
                -- "erlang",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "graphql",
                "html",
                "http",
                "ini",
                "java",
                "javascript",
                "jq",
                "jsdoc",
                "json",
                "json5",
                "latex",
                -- "llvm",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                -- "nix",
                "ocaml",
                "perl",
                "php",
                "phpdoc",
                "prisma",
                "proto",
                "python",
                "r",
                "regex",
                "ruby",
                "rust",
                "scss",
                "sql",
                "svelte",
                "sxhkdrc",
                "terraform",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "yaml",
                -- "zig",
            },

            -- If you need all the languages installed uncomment next line (perf hit)
            -- ensure_installed = "all",
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
        }
    end
}
