return {
    "echasnovski/mini.nvim",
    branch = "stable",
    config = function()
        -- require("mini.files").setup()
        -- require("mini.pairs").setup()
        require("mini.surround").setup()
        require("mini.comment").setup()
        require("mini.starter").setup({
            header = function()
                local Group = require("colorbuddy").Group
                local colors = require("colorbuddy").colors

                Group.new("MiniStarterHeader", colors.primary)
                Group.new("MiniStarterFooter", colors.secondary)

                local val = [[
    ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓    ▄▄▄▄   ▄▄▄█████▓ █     █░
     ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒   ▓█████▄ ▓  ██▒ ▓▒▓█░ █ ░█░
    ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░   ▒██▒ ▄██▒ ▓██░ ▒░▒█░ █ ░█
    ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██    ▒██░█▀  ░ ▓██▓ ░ ░█░ █ ░█
    ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒   ░▓█  ▀█▓  ▒██▒ ░ ░░██▒██▓
    ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░   ░▒▓███▀▒  ▒ ░░   ░ ▓░▒ ▒
    ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░   ▒░▒   ░     ░      ▒ ░ ░
       ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░       ░    ░   ░        ░   ░
             ░    ░  ░    ░ ░        ░   ░         ░       ░                   ░
                                    ░                           ░
]]
                return val
            end,
        })
        require("mini.trailspace").setup()
        require("mini.ai").setup()
        -- require("mini.indentscope").setup()
    end,
}
