local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("Berkeley Mono")
config.font_size = 11.0
config.use_fancy_tab_bar = false
-- config.show_tabs_in_tab_bar = false
-- config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.tab_bar_at_bottom = true
-- config.color_scheme = "Catppuccin Mocha"

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

config.window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 13,
}

config.colors = {
    -- The default text color
    foreground = "#d5d5d5",
    -- The default background color
    background = "#121212",

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = "#ff0088",
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = "#121212",
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = "#323232",

    -- the foreground color of selected text
    selection_fg = "#121212",
    -- the background color of selected text
    selection_bg = "#b0b0b0",

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    -- scrollbar_thumb = "#222222",

    -- The color of the split lines between panes
    -- split = "#444444",

    ansi = {
        "#121212",
        "#ff0088",
        "#00ff77",
        "white",
        "#b0b0b0",
        "#787878",
        "#d5d5d5",
        "#737373",
    },
    brights = {
        "#7a7a7a",
        "#ff0088",
        "#00ff77",
        "white",
        "white",
        "#787878",
        "#737373",
        "white",
    },

    -- Arbitrary colors of the palette in the range from 16 to 255
    -- indexed = { [136] = "#af8700" },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    -- compose_cursor = "orange",

    -- Colors for copy_mode and quick_select
    -- available since: 20220807-113146-c2fee766
    -- In copy_mode, the color of the active text is:
    -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
    -- 2. selection_* otherwise
    copy_mode_active_highlight_bg = { Color = "#000000" },
    -- use `AnsiColor` to specify one of the ansi color palette values
    -- (index 0-15) using one of the names "Black", "Maroon", "Green",
    --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
    -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
    copy_mode_active_highlight_fg = { AnsiColor = "Black" },
    copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
    copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

    quick_select_label_bg = { Color = "peru" },
    quick_select_label_fg = { Color = "#ffffff" },
    quick_select_match_bg = { AnsiColor = "Navy" },
    quick_select_match_fg = { Color = "#ffffff" },

    tab_bar = {
        background = "#323232", -- Background color of the tab bar

        active_tab = {
            bg_color = "#121212", -- Background color of the active tab
            fg_color = "#d5d5d5", -- Foreground color (text) of the active tab
            italic = false,
        },

        inactive_tab = {
            bg_color = "#323232", -- Background color of inactive tabs
            fg_color = "#d5d5d5", -- Foreground color (text) of inactive tabs
            -- italic = true,
        },

        inactive_tab_hover = {
            bg_color = "#323232", -- Background color when hovering over an inactive tab
            fg_color = "#ff0088",
            -- italic = true,
        },

        new_tab = {
            bg_color = "#323232",
            fg_color = "#d5d5d5",
        },

        new_tab_hover = {
            bg_color = "#323232",
            fg_color = "#ff0088",
        },
    },
}

return config
