local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
    return
end


nvim_tree.setup {
    renderer = {
        icons = {
            glyphs = {
                default = "",
            }
        }
    },
    disable_netrw = true,
    hijack_netrw = true,
    -- open_on_setup = false,
    -- ignore_ft_on_setup = {
    --     "startify"
    -- },
    hijack_cursor = false,
    update_focused_file = {
        enable = true,
        update_cwd = true,
        update_root = true,
        ignore_list = {}
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 400
    },
    hijack_directories = {
        enable = false,
        auto_open = false
    },
    filters = {
        custom = { ".git" },
        exclude = { ".gitignore", ".github", ".env", ".env.development", ".eslintrc", ".prettierrc" }
    },
    -- Make nvim-tree work nice with project.nvim  sync_root_with_cwd = true,
    respect_buf_cwd = true,
}
