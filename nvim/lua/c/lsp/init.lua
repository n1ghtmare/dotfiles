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
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
-- Ensure LSP servers installed through Mason
require("mason-lspconfig").setup {
    ensure_installed = {
        "prismals",
        "sumneko_lua",
        "tsserver",
        "eslint",
        "tailwindcss"
    }
}

require("c.lsp.null-ls")
-- Ensure null-ls formatters installed through Mason
require("mason-null-ls").setup {
    ensure_installed = {
        -- "cspell",
        "eslint_d",
        "prettierd"
    }
}


local lspconfig = require("lspconfig")

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
    on_attach = function(_, bufnr)
        require("c.keybindings").lsp_keybindings_for_buffer(bufnr)
    end
}

-- ESLint (Typescipt and Javascript)
lspconfig.eslint.setup {}

-- TailwindCSS
lspconfig.tailwindcss.setup {}

-- Prisma
lspconfig.prismals.setup {}

-- Typescript
lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.document_highlight then
            vim.api.nvim_exec(
                [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]]   ,
                false
            )
        end

        -- this way we keep keybindings in one place
        require("c.keybindings").lsp_keybindings_for_buffer(bufnr)
    end
}
