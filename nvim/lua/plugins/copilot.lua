return {
    "github/copilot.vim",
    lazy = true,
    config = function()
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_no_tab_map = true
    end
}
