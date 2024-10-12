-- Flash: Jump mode that integrates with '/' and enhances f/F/t/T

return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            search = { enabled = true },
            char = {
                highlight = {
                    backdrop = false,
                    groups = { label = "FlashCurrent" },
                },
            },
        },
    },
}
