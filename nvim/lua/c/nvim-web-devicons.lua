local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not status_ok then
    return
end

local status_ok_colors, colors = pcall(require, "noirbuddy.colors")

if not status_ok_colors then
    return
end

local c = colors.all()

nvim_web_devicons.setup {
    color_icons = false,
    default = true
}

local current_icons = nvim_web_devicons.get_icons()
local new_icons = {}

for key, icon in pairs(current_icons) do
    icon.color = c.gray_6
    -- icon.cterm_color = 246
    new_icons[key] = icon
end

nvim_web_devicons.set_icon(new_icons)
nvim_web_devicons.set_default_icon('', c.primary)
