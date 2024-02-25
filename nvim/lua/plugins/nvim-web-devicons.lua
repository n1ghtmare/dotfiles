return {
    "kyazdani42/nvim-web-devicons",
    dependencies = {
        "jesseleite/nvim-noirbuddy",
    },
    lazy = true,
    opts = {
        color_icons = false,
        default = true
    },
    config = function()
        local colors = require("noirbuddy.colors")
        local c = colors.all()

        local nvim_web_devicons = require("nvim-web-devicons")
        local current_icons = nvim_web_devicons.get_icons()
        local new_icons = {}

        for key, icon in pairs(current_icons) do
            icon.color = c.gray_6
            -- icon.cterm_color = 246
            new_icons[key] = icon
        end
        nvim_web_devicons.set_icon(new_icons)
        nvim_web_devicons.set_default_icon('', c.primary)
    end
}
