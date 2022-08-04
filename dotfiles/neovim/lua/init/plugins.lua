require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'sheerun/vim-polyglot'
	use 'nvim-treesitter/nvim-treesitter'
	use 'mhartington/formatter.nvim'
	use 'marko-cerovac/material.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-lualine/lualine.nvim'
	use 'phaazon/hop.nvim'
	use 'kevinhwang91/rnvimr'
	use 'tpope/vim-fugitive'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'karb94/neoscroll.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'folke/trouble.nvim'
	use 'Lenovsky/nuake'
	use 'rstacruz/vim-closer'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'dcampos/nvim-snippy'
	use 'dcampos/cmp-snippy'
	use 'honza/vim-snippets'
	use 'ray-x/lsp_signature.nvim'
end)

local installed_plugins = vim.fn.readdir(vim.fn.stdpath('data') .. '/site/pack/packer/start')
if #installed_plugins < 2 then
	return false
end
return true
