-- TODO: Example todo
-- FIXME: Example fixme note
-- HACK: This is a nasty hack
-- PERF: This is slow
require("todo-comments").setup {
    keywords = {
        TODO = { icon = " ", color = "info" },
    },
    colors = {
        info = { "Comment" },
        error = { "WarningMsg" }
    },
    highlight = {
        keyword = "bg",
        after = "fg"
    }
}
