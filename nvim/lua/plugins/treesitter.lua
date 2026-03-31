return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
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

        -- Incremental selection: Neovim 0.12 has built-in `an` (expand) and `in` (shrink)
        -- in visual mode. Remap to your old <C-space> / <C-backspace> keybinds.
        -- NOTE: <C-s> scope_incremental has no built-in equivalent and is lost.
        vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Init treesitter selection" })
        vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Increment treesitter selection" })
        vim.keymap.set("x", "<C-backspace>", "in", { remap = true, desc = "Decrement treesitter selection" })

        -- Textobjects config
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        })

        local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
        local swap = require("nvim-treesitter-textobjects.swap")
        local move = require("nvim-treesitter-textobjects.move")

        -- Select keymaps (visual + operator-pending)
        vim.keymap.set({ "x", "o" }, "aa", function()
            select_textobject("@parameter.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ia", function()
            select_textobject("@parameter.inner", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "af", function()
            select_textobject("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "if", function()
            select_textobject("@function.inner", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ac", function()
            select_textobject("@class.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "ic", function()
            select_textobject("@class.inner", "textobjects")
        end)

        -- Move keymaps (normal + visual + operator-pending)
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

        -- Treat handlebars as html
        vim.treesitter.language.register("html", "handlebars", "hbs")
    end,
}
