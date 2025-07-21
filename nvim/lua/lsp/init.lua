-- Setup how diagnostics should appear in neovim
local function setup_lsp_diagnostics()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
            },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
end

setup_lsp_diagnostics()

-- Have a border around the lsp hover window
local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
    ---@diagnostic disable-next-line: redundant-parameter
    return hover({
        max_width = 110,
        border = "single",
    })
end

-- Better auto completion capabilities (expand the built in ones)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

require("mason").setup()

-- Ensure LSP servers and formatters are installed through Mason upon Neovim
-- startup, if not already installed.
require("mason-tool-installer").setup({
    ensure_installed = {
        -- LSP Servers
        "gopls",
        -- "prismals",
        "lua-language-server",
        "typescript-language-server",
        -- "eslint_d",
        "css-lsp",
        "tailwindcss-language-server",
        -- "rust_analyzer",
        "vue-language-server", -- Vue
        "bash-language-server", -- Bash

        -- Formatters
        "eslint_d",
        "prettierd",
        "stylua",
    },
})

local lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- LuaJIT in the case of neovim
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the "vim" global
                globals = { "vim" },
            },
        },
    },
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            cargo = {
                allFeatures = true,
            },
        },
    },
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- ESLint (Typescipt and Javascript)
lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- CSS
lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- TailwindCSS
lspconfig.tailwindcss.setup({})

-- Golang
lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- Prisma
lspconfig.prismals.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- Vue.js
lspconfig.volar.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- Typescript
local vue_language_server_path = vim.fn.expand("$MASON/packages")
    .. "/vue-language-server"
    .. "/node_modules/@vue/language-server"

lspconfig.ts_ls.setup({
    init_options = {
        plugins = {
            {
                -- Name of the TypeScript plugin for Vue
                name = "@vue/typescript-plugin",

                -- Location of the Vue language server module (path defined in step 1)
                location = vue_language_server_path,

                -- Specify the languages the plugin applies to (in this case, Vue files)
                languages = { "vue" },
            },
        },
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.document_highlight then
            vim.api.nvim_exec(
                [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
                false
            )
        end

        -- this way we keep keybindings in one place
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
    -- Specify the file types that will trigger the TypeScript language server
    filetypes = {
        "typescript", -- TypeScript files (.ts)
        "javascript", -- JavaScript files (.js)
        "javascriptreact", -- React files with JavaScript (.jsx)
        "typescriptreact", -- React files with TypeScript (.tsx)
        "vue", -- Vue.js single-file components (.vue)
    },
})
