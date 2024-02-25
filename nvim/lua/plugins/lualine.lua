return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "jesseleite/nvim-noirbuddy",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        -- Option 1:
        local noirbuddy_lualine = require("noirbuddy.plugins.lualine")

        local theme = noirbuddy_lualine.theme
        -- optional, you can define those yourself if you need
        local sections = noirbuddy_lualine.sections
        local inactive_sections = noirbuddy_lualine.inactive_sections

        require("lualine").setup {
            options = {
                icons_enabled = true,
                theme = theme,
                filetype = { colored = false },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = sections,
            inactive_sections = inactive_sections,
        }

        -- Option 2:
        --[[ local status_ok_colors, colors = pcall(require, "noirbuddy.colors")

        if not status_ok_colors then
            return
        end

        local c = colors.all()

        local theme = {
            normal = {
                a = { fg = c.gray_2, bg = c.gray_8, gui = "bold" },
                b = { fg = c.gray_3, bg = c.gray_9 },
                c = { fg = c.gray_3, bg = c.gray_8 },
            },
            insert = { a = { fg = c.black, bg = c.gray_2, gui = "bold" } },
            visual = { a = { fg = c.black, bg = c.primary, gui = "bold" } },
            replace = { a = { fg = c.black, bg = c.gray_1, gui = "bold" } },
            inactive = {
                a = { fg = c.gray_1, bg = c.black },
                b = { fg = c.gray_1, bg = c.black },
                c = { fg = c.gray_1, bg = c.black },
            },
        }

        lualine.setup {
            options = {
                icons_enabled = true,
                theme = theme,
                filetype = { colored = false },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", { "diagnostics", color = { bg = c.black } } },
                lualine_c = { "filename" },
                lualine_x = { "encoding", { "filetype", colored = false } },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {}
            }
        } ]]
    end
}
