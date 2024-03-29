-- We use null-ls for formatting
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

-- local function lsp_formatting(bufnr, target_client_name)
--     vim.lsp.buf.format({
--         filter = function(client)
--             return client.name == target_client_name
--         end,
--         bufnr = bufnr
--     })
-- end

-- callback used to format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function setup_null_ls_formatting(client, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            -- lsp_formatting(bufnr, client)
            vim.lsp.buf.format({ bufnr, async = false })
        end
    })
end

-- local code_actions = null_ls.builtins.code_actions;
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- npm install --save-dev prettier
null_ls.setup {
    on_attach = function(client, bufnr)
        setup_null_ls_formatting(client, bufnr)
    end,
    debug = false,
    sources = {
        -- diagnostics.cspell,
        -- code_actions.cspell,
        diagnostics.eslint_d, -- :!which eslint_d (to get where eslint_d is installed - mason/bin dir location)
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
                "handlebars",
                -- "markdown",
                "graphql",
            },
        },
        formatting.rustfmt,
        -- formatting.prismaFmt,
        -- black is a formatter for python (https://pypi.org/project/black):
        -- formatting.black.with { extra_args = { "--fast" } },
    },
}
