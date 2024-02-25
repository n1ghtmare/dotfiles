return {
    -- TODO: Example todo
    -- FIXME: Example fixme note
    -- HACK: This is a nasty hack
    -- PERF: This is slow
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        keywords = {
            TODO = { icon = " ", color = "info" },
        },
        colors = {
            info = { "Comment" },
            error = { "WarningMsg" },
        },
        highlight = {
            keyword = "bg",
            after = "fg"
        }
    }
}
