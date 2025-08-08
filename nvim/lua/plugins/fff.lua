return {
    "dmtrKovalenko/fff.nvim",
    dependencies = {
        { "folke/snacks.nvim" },
    },
    build = "cargo build --release",
    opts = {
        -- pass here all the options
        prompt = "> ",
    },
}
