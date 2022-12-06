local status_ok, noirbuddy = pcall(require, "noirbuddy")

if not status_ok then
    return
end

noirbuddy.setup({
    diagnostic_error = "#ff0038",
    diff_add = "#00ff77",
    diff_change = "#d5d5d5",
    diff_delete = "#ff0038",
    styles = {
        italic = false,
        undercurl = false,
        bold = true,
        underline = true,
    }
})
