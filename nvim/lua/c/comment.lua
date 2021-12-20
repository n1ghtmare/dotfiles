local status_ok, comment = pcall(require, "Comment")

if not status_ok then
    return
end

-- For settings, check -> https://github.com/numToStr/Comment.nvim
comment.setup {}
