return {
    "L3MON4D3/LuaSnip",
    config = function()
        local ls = require("luasnip")
        -- print("loaded ls")

        -- Snippet keymappings:
        -- MAP: ctrl+k will expand the current item or jump to the next item within the snippet
        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        -- MAP: ctrl+j will jump to the previous item within the snippet
        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if ls.expand_or_jumpable(-1) then
                ls.expand_or_jump(-1)
            end
        end, { silent = true })

        -- MAP: ctrl+l will select within a list of snippet options (cycle through the list)
        -- vim.keymap.set("i", "<c-l>", function()
        --     if ls.choice_active() then
        --         ls.change_choice(1)
        --     end
        -- end)

        local js_cl_snippet = ls.parser.parse_snippet("cl", "console.log($1);")


        -- TODO: Add your own snippets here
        ls.add_snippets(nil, {
            -- Available in any filetype
            all = {
                ls.parser.parse_snippet("expand", "-- this is what was expanded!")
            },
            typescript = {
                js_cl_snippet
            },
            typescriptreact = {
                js_cl_snippet
            },
            javascript = {
                js_cl_snippet
            },
            javasriptreact = {
                js_cl_snippet
            },
            lua = {
                -- Lua specific snippets go here
                ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend")
            },
        })
    end
}
