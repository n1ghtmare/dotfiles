-- We use null-ls for formatting
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
        diagnostics.eslint_d,
        formatting.prettierd.with {
            -- prefer_local = "node_modules/.bin",
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
            -- formatting.prismaFmt,
        },
        formatting.rustfmt,
        -- black is a formatter for python (https://pypi.org/project/black):
        -- formatting.black.with { extra_args = { "--fast" } },
    },
}
