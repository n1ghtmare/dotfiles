return {
    "dmtrKovalenko/fff.nvim",
    -- dir = "/home/ddimitrov/Dev/fff.nvim",
    -- name = "fff.nvim",
    build = function()
        -- this will download prebuild binary or try to use existing rustup toolchain to build from source
        -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
        require("fff.download").download_or_build_binary()
    end,
    opts = { -- (optional)
        debug = {
            enabled = true, -- we expect your collaboration at least during the beta
            show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
        },
        prompt = "> ",
        layout = {
            prompt_position = "top",
            height = 0.65,
            anchor = "bottom_left",
        },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
        -- Keybindings are in nvim/lua/keybindings.lua, but here are some defaults
        -- {
        --     "ff", -- try it if you didn't it is a banger keybinding for a picker
        --     function()
        --         require("fff").find_files()
        --     end,
        --     desc = "FFFind files",
        -- },
        -- {
        --     "fg",
        --     function()
        --         require("fff").live_grep()
        --     end,
        --     desc = "LiFFFe grep",
        -- },
        -- {
        --     "fz",
        --     function()
        --         require("fff").live_grep({
        --             grep = {
        --                 modes = { "fuzzy", "plain" },
        --             },
        --         })
        --     end,
        --     desc = "Live fffuzy grep",
        -- },
    },
}
