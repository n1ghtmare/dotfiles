local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not status_ok then
    return
end

nvim_web_devicons.setup {
    default = true
}

-- TODO: Move this to the noirblaze-vim colorscheme (where it belongs)
local current_icons = nvim_web_devicons.get_icons()
local new_icons = {}

for key, icon in pairs(current_icons) do
    icon.color = "#737373"
    icon.cterm_color = 246
    new_icons[key] = icon
end

nvim_web_devicons.set_icon(new_icons)
nvim_web_devicons.set_default_icon('', '#ff0088')
