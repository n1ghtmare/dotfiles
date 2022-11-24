local status_ok, noirbuddy = pcall(require, "noirbuddy")

if not status_ok then
    return
end

-- package.loaded["noirbuddy"] = nil

-- V1
noirbuddy.setup({
    secondary = "#a7a7a7",
    diagnostic_error = "#ff0038",
    diagnostic_warning = "#ff7700",
    diagnostic_info = "#d5d5d5",
    diagnostic_hint = "#f5f5f5",
    diff_add = "#00ff77",
    diff_change = "#d5d5d5",
    diff_delete = "#ff0038",
})

-- V2
-- require("noirbuddy").setup({
--     secondary = "#a7a7a7",
--     diagnostic_error = "#ff0038",
--     diagnostic_warning = "#ff7700",
--     diagnostic_info = "#d5d5d5",
--     diagnostic_hint = "#f5f5f5",
--     diff_add = "#f5f5f5",
--     diff_change = "#737373",
--     diff_delete = "#ff0088",
-- })

-- vim.opt.background = "dark"
-- vim.cmd("colorscheme noirblaze")
