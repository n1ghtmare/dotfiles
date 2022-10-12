-- Setup how diagnostics should appear in neovim
local function setup_lsp_diagnostics()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
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

-- Better auto completion capabilities (expand the built in ones)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("mason").setup()
-- Ensure LSP servers installed through Mason
require("mason-lspconfig").setup {
    ensure_installed = {
        "sumneko_lua",
        "tsserver",
        "eslint",
        "tailwindcss"
    }
}

-- Ensure null-ls formatters installed through Mason
require("c.lsp.null-ls")
require("mason-null-ls").setup {
    ensure_installed = {
        "eslint_d",
        "prettierd"
    }
}


local lspconfig = require("lspconfig")

local function lsp_formatting(bufnr, target_client_name)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == target_client_name
        end,
        bufnr = bufnr
    })
end

-- callback used to format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function setup_null_ls_formatting(client, bufnr, target_client_name)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr, target_client_name)
            end
        })
    end
end

-- Lua
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the "vim" global
                globals = { "vim" }
            }
        }
    },
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("c.keybindings").lsp_keybindings_for_buffer(bufnr)
    end
}

-- Rust
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        setup_null_ls_formatting(client, bufnr, "null-ls") -- you can also pass rust_analyzer instead of null-ls (although null-ls itself uses rust_analyzer)

        require("c.keybindings").lsp_keybindings_for_buffer(bufnr)
    end
}

-- ESLint (Typescipt and Javascript)
lspconfig.eslint.setup {}

-- TailwindCSS
lspconfig.tailwindcss.setup {}

-- Typescript
lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        setup_null_ls_formatting(client, bufnr, "null-ls")

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
        require("c.keybindings").lsp_keybindings_for_buffer(bufnr)
    end
}
