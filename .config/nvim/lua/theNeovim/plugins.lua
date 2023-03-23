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
    use 'wbthomason/packer.nvim'
    use {
        'jiangmiao/auto-pairs',
    }
    use 'nvim-lua/popup.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use {
        'lifepillar/vim-gruvbox8',
        opt = true,
        module = 'vim-gruvbox8'
    }
    use {
        'nvim-treesitter/nvim-treesitter-context',
   }
    use {
        'norcalli/nvim-colorizer.lua',
    }
    --use 'ThePrimeagen/vim-be-good'
    use {
        'mbbill/undotree',
        opt = true,
        cmd = {'UndotreeToggle', 'UndotreeFocus', 'UndotreeShow', 'UndotreeHide'}
    }
    use {
        'nvim-treesitter/nvim-treesitter',
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },


            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

end)
