local status_ok, noirbuddy = pcall(require, "noirbuddy")

if not status_ok then
    return
end

noirbuddy.setup {
    colors = {
        diagnostic_info = '#d5d5d5',
        diagnostic_hint = '#f5f5f5',
        diff_add = "#00ff77",
        diff_change = "#d5d5d5",
        diff_delete = "#ff0038",
    },
    -- hello
    styles = {
        italic = false,
        undercurl = false,
        bold = true,
        underline = true,
    }
}
