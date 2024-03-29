return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" }, -- Required by telescope
        { "nvim-telescope/telescope-ui-select.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make", -- This plugin requires compilation
        },
    },
    -- TODO: See if we can write this config without the below (in lazy.nvim, we should be able to skip it??)
    config = function()
        require("telescope").setup {
            defaults = {
                color_devicons = false,
                layout_strategy = "vertical",
                sorting_strategy = "ascending",
                file_ignore_patterns = {
                    "^.git/"
                },
                -- layout_config = {
                --     width = 0.7,
                --     horizontal = {
                --         preview_width = 0.6
                --     },
                --     prompt_position = "top",
                --     vertical = {
                --         mirror = true,
                --     },
                -- },
                mappings = {
                    i = {
                        -- meta-p (== alt-p)
                        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
                    },
                    n = {
                        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
                    }
                }
            },
            pickers = {
                find_files = {
                    theme = "ivy",
                    previewer = false,
                    hidden = true,

                },
                buffers = {
                    theme = "ivy",
                    previewer = false,
                    ignore_current_buffer = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<c-d>"] = require("telescope.actions").delete_buffer,
                            -- or right hand side can also be the name of the action as string
                        },
                        n = {
                            ["<c-d>"] = require("telescope.actions").delete_buffer,
                        }
                    }
                },
                live_grep = {
                    theme = "ivy",
                    previewer = false,
                },
                diagnostics = {
                    theme = "ivy"
                },
                git_status = {
                    theme = "ivy"
                },
                help_tags = {
                    theme = "ivy"
                },
                git_files = {
                    theme = "ivy"
                },
                current_buffer_fuzzy_find = {
                    theme = "ivy"
                },
                lsp_document_symbols = {
                    theme = "ivy"
                },
                lsp_references = {
                    theme = "ivy"
                },
                marks = {
                    theme = "ivy"
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = false, -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ["ui-select"] = {
                    require("telescope.themes").get_ivy {
                        -- options here
                        layout_strategy = "bottom_pane"
                    }
                }
            }
        }


        require('telescope').load_extension('ui-select')
        require('telescope').load_extension('fzf')
    end,
}
