return {
    "n1ghtmare/scope-hints.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        -- mode = "cursor",  -- only annotate the scope the cursor is in
        mode = "cursor",
    },
}
