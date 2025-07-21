return {
    "echasnovski/mini.nvim",
    branch = "stable",
    config = function()
        require("mini.files").setup()
        require("mini.surround").setup()
        require("mini.comment").setup()
        require("mini.trailspace").setup()
        require("mini.ai").setup()
        require("mini.extra").setup()
        require("mini.indentscope").setup()
        require("mini.pairs").setup()

        --[[
        To select items and put them in quickfix with :MiniPick:
        - Search for whatever you want to select
        - When you have the list of items press <C-a> (Ctrl + a) to select all
        - Then press <M-CR> (Alt + Enter) to put them in quickfix
        To select items from multiple subsequent searches:
        - Search for whatever you want to select
        - When you have the list of items press <C-a> (Ctrl + a) to select all
        - Perform your next search
        - When you have the list of items press <C-a> (Ctrl + a) to select all
        - When you're done selecting all the items across searches press <M-CR>
        (Alt + Enter) to put them in quickfix

        For more info check this: https://github.com/echasnovski/mini.nvim/discussions/1853
        ]]
        -- require("mini.pick").setup()
        local MiniPick = require("mini.pick")
        MiniPick.setup()
        -- Set up the global `vim.ui.select` function to use MiniPick (this
        -- will work with Code Actions for example)
        vim.ui.select = MiniPick.ui_select
    end,
}
