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
require("mason-lspconfig").setup{
    ensure_installed = { "sumneko_lua", "tsserver", "prettierd", "eslint", "tailwindcss" }
}


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

-- ESLint (Typescipt and Javascript)
lspconfig.eslint.setup{}

-- TailwindCSS
lspconfig.tailwindcss.setup{}

-- Typescript
lspconfig.tsserver.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)

    -- Once we upgrade to neovim 0.8 see my TODO below
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

require("c.lsp.null-ls")

-- TODO: This won't work until neovim 0.8, once it works, clean the shit above for the typescript on_attach function
--[[ -- Formatting functions
local function lsp_formatting(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- Formatting on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local function on_attach(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end

    -- Attach keybindings - this way we can keep them in a separate file
    require("c.keybindings").lsp_keybindings_for_buffer(bufnr)
end ]]
