-- A plugin that adds file management using a neovim buffer
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        keymaps = {
            ["<C-h>"] = false,
            ["<C-v>"] = "actions.select_vsplit",
        },
        view_options = {
            show_hidden = true,
        },
    },
}
