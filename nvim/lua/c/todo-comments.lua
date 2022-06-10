local status_ok, todo_comments = pcall(require, "todo-comments")

if not status_ok then
    return
end

-- TODO: Example todo
-- FIXME: Example fixme note
-- HACK: This is a nasty hack
-- PERF: This is slow
todo_comments.setup {
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
