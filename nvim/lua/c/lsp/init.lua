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

require("nvim-lsp-installer").setup()

local lspconfig = require("lspconfig")

-- Lua
lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the "vim" global
                globals = {"vim"}
            }
        }
    },
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("c.keybindings").lsp_keybindings_for_buffer(bufnr)
    end
}

-- Typescript
lspconfig.tsserver.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)

    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
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
-- require("c.lsp.nvim-lsp-installer")
-- require("c.lsp.handlers").setup()
require("c.lsp.null-ls")
