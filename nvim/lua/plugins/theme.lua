return {
    -- dir = "~/Dev/nvim-noirbuddy/",
    "jesseleite/nvim-noirbuddy",
    dependencies = {
        { "tjdevries/colorbuddy.nvim" },
    },
    lazy = false,
    priority = 1000,
    opts = {
        preset = "oxide",
        -- colors = {
        --     -- primary = "#00d992",
        --     -- diagnostic_info = "#d5d5d5",
        --     -- diagnostic_hint = "#f5f5f5",
        --     -- diff_add = "#00ff77",
        --     -- diff_change = "#d5d5d5",
        --     -- diff_delete = "#ff0038",
        -- },
        styles = {
            italic = false,
            undercurl = false,
            bold = true,
            underline = true,
        },
    },
}
