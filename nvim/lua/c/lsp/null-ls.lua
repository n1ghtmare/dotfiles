local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- npm install --save-dev prettier
null_ls.setup {
    debug = false,
    sources = {
        formatting.prettier.with {
            command = "node_modules/.bin/prettier", -- hack to enable local usage of prettier (instead of globally installed one)
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "css",
                "scss",
                "less",
                "html",
                "json",
                "yaml",
                -- "markdown",
                "graphql",
            },
        },
        formatting.black.with { extra_args = { "--fast" } },
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end
    end,
}
