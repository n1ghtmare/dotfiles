return require('packer').startup(function()
    -- packer (can manage itself)
    use 'wbthomason/packer.nvim'

    -- theme
    use 'n1ghtmare/noirblaze-vim'

    -- status line (top and bottom)
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    -- tree explorer
    use {
        'preservim/nerdtree',
        requires = { 'ryanoasis/vim-devicons' }
    }
end)

