-- these are configured in ./lua/lsp/init.lua
-- TODO: See if we can move the settings here
return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- "zapling/mason-conform.nvim",
        -- "jayp0521/mason-null-ls.nvim", -- ensure installed null_ls dependencies through Mason
        "simrat39/rust-tools.nvim",
    },
    lazy = true,
}
