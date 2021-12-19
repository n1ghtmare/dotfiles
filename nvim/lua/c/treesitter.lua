local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not status_ok then
    return
end

treesitter.setup({
    ensure_installed = "maintained",
    sync_install = false,
    highlight = {
        enable = true, -- for now disabled the whole syntax thing
        -- disable for certain languages
        --disable = {"tsx", "typescript"},
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true,
    }
})
