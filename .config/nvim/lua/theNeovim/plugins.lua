local status_ok , packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init {
    display = {
        open_fn = function ()
        	return require("packer.util").float { border = "rounded" }
        end,
    },
}

require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use { 'jiangmiao/auto-pairs',
        opt = true,
        event = 'BufWinEnter'
    }

    use { 'nvim-lua/popup.nvim' }

    use { 'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }

    use { 'lifepillar/vim-gruvbox8',
        opt = true,

    }

    use { 'norcalli/nvim-colorizer.lua',
        opt = true,
        event = 'BufWinEnter'
    }

    use { 'nvim-treesitter/nvim-treesitter', }

    use { 'VonHeikemen/lsp-zero.nvim',
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after  = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after  = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after  = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after  = 'nvim-cmp' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
    }
end)
