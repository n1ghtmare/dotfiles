-- Conform is a plugin that gives you formatting
return {
    "stevearc/conform.nvim",
    opts = {
        -- Formatters by file type
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
            javascript = { { "prettierd", "prettier" } },
            javascriptreact = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            typescriptreact = { { "prettierd", "prettier" } },
            json = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
}
