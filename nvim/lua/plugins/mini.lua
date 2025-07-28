-- Custom MiniPick Buffers sorted by recency and with the ability to wipe out
-- the selected buffer by pressing <C-d> (Ctrl + d)
-- It will also not show the current buffer in the list.
local function custom_mini_pick_buffers(MiniPick)
    local wipeout_cur = function()
        vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
    end

    local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }
    -- Custom picker for buffers to sort them by last used
    MiniPick.registry.my_buffers = function()
        local items, cwd = {}, vim.fn.getcwd()
        for _, buf_info in ipairs(vim.fn.getbufinfo()) do
            if buf_info.listed == 1 and buf_info.bufnr ~= vim.api.nvim_get_current_buf() then
                local name = vim.fs.relpath(cwd, buf_info.name) or buf_info.name
                table.insert(items, {
                    text = name,
                    bufnr = buf_info.bufnr,
                    _lastused = buf_info.lastused,
                })
            end
        end

        table.sort(items, function(a, b)
            return a._lastused > b._lastused
        end)

        local show = function(buf_id, items_to_show, query)
            MiniPick.default_show(buf_id, items_to_show, query, { show_icons = true })
        end

        local opts = {
            source = { name = "Buffers", items = items, show = show },
            mappings = buffer_mappings,
        }
        return MiniPick.start(opts)
    end
end

return {
    "echasnovski/mini.nvim",
    branch = "stable",
    config = function()
        require("mini.files").setup()
        require("mini.surround").setup()
        require("mini.comment").setup()
        require("mini.trailspace").setup()
        require("mini.ai").setup()
        require("mini.extra").setup()
        require("mini.indentscope").setup()
        require("mini.pairs").setup()

        --[[
        To select items and put them in quickfix with :MiniPick:
        - Search for whatever you want to select
        - When you have the list of items press <C-a> (Ctrl + a) to select all
        - Then press <M-CR> (Alt + Enter) to put them in quickfix
        To select items from multiple subsequent searches:
        - Search for whatever you want to select
        - When you have the list of items press <C-a> (Ctrl + a) to select all
        - Perform your next search
        - When you have the list of items press <C-a> (Ctrl + a) to select all
        - When you're done selecting all the items across searches press <M-CR>
        (Alt + Enter) to put them in quickfix

        For more info check this: https://github.com/echasnovski/mini.nvim/discussions/1853
        ]]
        -- require("mini.pick").setup()
        local MiniPick = require("mini.pick")
        MiniPick.setup()
        -- Set up the global `vim.ui.select` function to use MiniPick (this
        -- will work with Code Actions for example)
        vim.ui.select = MiniPick.ui_select

        custom_mini_pick_buffers(MiniPick)
    end,
}
