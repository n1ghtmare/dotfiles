local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

nvim_tree.setup {
    git = {
        enable = false,
        ignore = true
    },
    update_to_buf_dir = {
        enable = false,
        auto_open = false
    }
}


