local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install plugins here
return require("packer").startup(function(use)
    -- packer (can manage itself)
    use "wbthomason/packer.nvim"

    -- icons (used with lualine, bufferline, nvim-tree, telescope, vim-startify
    use "kyazdani42/nvim-web-devicons"

    -- status line (bottom)
    use "nvim-lualine/lualine.nvim"

    -- telescope (search for files, buffers, content etc.)
    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }
    -- use { "nvim-telescope/telescope-file-browser.nvim" }
    use { "nvim-telescope/telescope-ui-select.nvim" }

    -- search/replace preview
    use "markonm/traces.vim"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "jayp0521/mason-null-ls.nvim" -- ensure installed null_ls dependencies through Mason
    use 'simrat39/rust-tools.nvim'    -- rust specific tools

    -- useful status updates
    use { "j-hui/fidget.nvim", tag = "legacy" }

    -- auto-completion
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"              -- buffer completion
    use "hrsh7th/cmp-path"                -- path completion
    use "hrsh7th/cmp-cmdline"             -- comand line completion
    use "hrsh7th/nvim-cmp"                -- code completion
    use "L3MON4D3/LuaSnip"                -- for snippets (required with nvim-cmp)
    use "saadparwaiz1/cmp_luasnip"        -- make snippets work with cmp
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

    -- code todo comments
    use {
        "folke/todo-comments.nvim",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Treesitter (syntax highlighting, indentation etc)
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    use { "nvim-treesitter/playground", after = "nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-context", after = "nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }

    -- support plugin to show shortcuts
    use "folke/which-key.nvim"

    -- visualize your undo
    use "mbbill/undotree"

    -- git signs
    use "mhinz/vim-signify"

    -- detect tabstop and shiftwidth automatically
    use "tpope/vim-sleuth"

    -- git integrations
    use "tpope/vim-fugitive"

    -- colorbuddy -> for now used for development
    use {
        "~/Dev/nvim-noirbuddy",
        -- "jesseleite/nvim-noirbuddy",
        requires = { "tjdevries/colorbuddy.nvim", branch = "dev" }
    }

    -- make editorconfig work with neovim
    use "gpanders/editorconfig.nvim"

    -- Github copilot
    use "github/copilot.vim"

    -- Comments -> gc
    use "numToStr/Comment.nvim"

    -- autopairs -> auto close brackets, quotes etc.
    use "windwp/nvim-autopairs"

    -- ecosystem for various small plugins currently using it for
    -- file browser (mini.files) 
    -- surround (mini.surround)
    -- start (mini.starter) (similar to vim-startify)
    -- trailing spaces trimmer (mini.trailspace)
    use { "echasnovski/mini.nvim", branch = "stable" }
end)
