local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not status_ok then 
    return
end

nvim_web_devicons.setup {
    override = {
        default_icon = {
            icon = " ",
            color = "#6d8086",
            name = "Default",
        }
    },
    default = false
}
nvim_web_devicons.set_default_icon('', '#ff0088')
