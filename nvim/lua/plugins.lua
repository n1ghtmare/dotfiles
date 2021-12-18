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

-- Use a protected call so we don't error out on first use
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
return require("packer").startup(function()
    -- packer (can manage itself)
    use "wbthomason/packer.nvim"

    -- theme
    use "n1ghtmare/noirblaze-vim"

    -- icons (used with lualine, bufferline, nvim-tree, telescope, vim-startify
    use "kyazdani42/nvim-web-devicons"

    -- status line (bottom)
    use "nvim-lualine/lualine.nvim"

    -- bufferline (top)
    use "akinsho/bufferline.nvim"

    -- tree explorer
    use 'kyazdani42/nvim-tree.lua'

    -- telescope (search for files, buffers, content etc.)
    use {
        "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }

    -- search/replace preview
    use "markonm/traces.vim"

    -- see (and auto remove) white space
    --use "ntpeters/vim-better-whitespace"

    -- startup UI
    use "mhinz/vim-startify"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"

    -- auto-completion
    use "hrsh7th/cmp-nvim-lsp"
    use 'hrsh7th/cmp-buffer' -- buffer completion
    use 'hrsh7th/cmp-path' -- path completion
    use 'hrsh7th/cmp-cmdline' -- comand line completion
    use "hrsh7th/nvim-cmp" -- code completion
    use "L3MON4D3/LuaSnip" -- for snippets (required with nvim-cmp)
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
end)

