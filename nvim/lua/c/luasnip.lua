local status_ok, ls = pcall(require, "luasnip")

if not status_ok then
    return
end

-- print("loaded ls")

-- Snippet keymappings:
-- MAP: ctrl+k will expand the current item or jump to the next item within the snippet
vim.keymap.set({"i", "s"}, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true})

-- MAP: ctrl+j will jump to the previous item within the snippet
vim.keymap.set({"i", "s"}, "<c-j>", function()
    if ls.expand_or_jumpable(-1) then
        ls.expand_or_jump(-1)
    end
end, {silent = true})

-- MAP: ctrl+l will select within a list of snippet options (cycle through the list)
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- TODO: Add your own snippets here
ls.add_snippets(nil, {
    all = {
        -- Available in any filetype
        ls.parser.parse_snippet("expand", "-- this is what was expanded!")
    },
    lua = {
        -- Lua specific snippets go here
        ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend")
    },
})
