-- these are configured in ./lua/lsp/init.lua
-- TODO: See if we can move the settings here
return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "simrat39/rust-tools.nvim",
    },
    lazy = true,
}
