return {
    "github/copilot.vim",
    lazy = false,
    cond = false, -- Disable copilot for the time being, remove this line to enable it again
    config = function()
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_no_tab_map = true
    end,
}
