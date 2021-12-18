local status_ok, _ = pcall(require, "lspconfig")

if not status_ok then
    return
end

require("c.lsp.nvim-lsp-installer")
require("c.lsp.handlers").setup()
require("c.lsp.null-ls")
