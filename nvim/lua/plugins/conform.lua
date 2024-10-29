-- Conform is a plugin that gives you formatting
return {
    "stevearc/conform.nvim",
    opts = {
        -- Formatters by file type
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            vue = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            css = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters = {
            stylua = {
                args = { "--indent-type", "Spaces", "--indent-width", "4", "-" },
            },
        },
    },
}
