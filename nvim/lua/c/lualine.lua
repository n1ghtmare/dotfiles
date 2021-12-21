local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
    return
end

-- TODO: Port the entire theme to lua
local colors = {
    black = "#000000",
    hot_pink = "#ff0088",
    white = "#ffffff",
    gray_900 = "#121212",
    gray_800 = "#323232",
    gray_700 = "#535353",
    gray_600 = "#737373",
    gray_500 = "#949494",
    gray_400 = "#b4b4b4",
    gray_300 = "#d5d5d5",
    gray_200 = "#f5f5f5",
    zinc_gray_900 = "#212121",
    zinc_gray_600 = "#7a7a7a",
    zinc_gray_500 = "#787878",
    zinc_gray_200 = "#b0b0b0",
}

local noirblaze_theme = {
    normal = {
        a = { fg = colors.gray_300, bg = colors.gray_800, gui = "bold" },
        b = { fg = colors.gray_400, bg = colors.zinc_gray_900 },
        c = { fg = colors.gray_400, bg = colors.gray_800 },
    },

    insert = { a = { fg = colors.gray_900, bg = colors.gray_300, gui = "bold" } },
    visual = { a = { fg = colors.gray_900, bg = colors.hot_pink, gui = "bold" } },
    replace = { a = { fg = colors.gray_900, bg = colors.gray_200, gui = "bold" } },

    -- TODO: Figure out a what this shit below is used for
    inactive = {
        a = { fg = colors.gray_200, bg = colors.gray_900 },
        b = { fg = colors.gray_200, bg = colors.gray_900 },
        c = { fg = colors.gray_200, bg = colors.gray_900 },
    },
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = noirblaze_theme,

    filetype = {
        colored = false
    },
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', {'filetype', colored = false}},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
