local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
    return
end

vim.g.nvim_tree_icons = {
    default = "",
}

nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify"
    },
    auto_close = true,
    hijack_cursor = false,
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {}
    },
    git = {
        enable = false,
        ignore = true
    },
    update_to_buf_dir = {
        enable = false,
        auto_open = false
    },
}


