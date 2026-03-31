-- You need to install `pacman -S tree-sitter-cli` for this to work
return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        require("treesitter-context").setup({ enable = true })

        -- New plugin setup — only handles parser installation, no module options
        require("nvim-treesitter").setup({})

        -- Enable highlighting and indentation via autocmd
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- ensure_installed replacement
        local ensure_installed = {
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
            "lua",
            "luadoc",
            "make",
            "markdown",
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
        }
        local installed = require("nvim-treesitter.config").get_installed()
        local to_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(installed, parser)
            end)
            :totable()
        if #to_install > 0 then
            require("nvim-treesitter").install(to_install)
        end

        -- Textobjects config
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        })

        -- Treat handlebars as html
        vim.treesitter.language.register("html", "handlebars", "hbs")
    end,
    build = ":TSUpdate",
}
