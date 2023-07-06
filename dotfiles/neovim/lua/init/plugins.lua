local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrapped = ensure_packer()
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-treesitter/nvim-treesitter'

	-- Colors and icons
	use 'marko-cerovac/material.nvim'
	use 'NvChad/nvim-colorizer.lua'
	use 'kyazdani42/nvim-web-devicons'

	-- Status line
	use 'nvim-lualine/lualine.nvim'

	-- Indentation Guides
	use 'lukas-reineke/indent-blankline.nvim'

	-- Movement
	use 'phaazon/hop.nvim'

	-- Ranger Intergration
	use 'kevinhwang91/rnvimr'

	-- Git
	use 'tpope/vim-fugitive'

	-- Smooth Scrolling
	use 'karb94/neoscroll.nvim'

	-- Drop Down Terminal
	use 'Lenovsky/nuake'

	-- Fuzzy finder
	use 'nvim-telescope/telescope.nvim'

	-- Diagnostics
	use 'folke/trouble.nvim'

	-- Automatic Brackets Closer
	use 'rstacruz/vim-closer'

	-- Surrounding Pairs Actions
	use 'kylechui/nvim-surround'

	-- Comment Actions
	use 'numToStr/Comment.nvim'

	-- Project Working Directory Management
	use 'ahmedkhalf/project.nvim'

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'jose-elias-alvarez/null-ls.nvim'
	use 'ray-x/lsp_signature.nvim'

	-- Autocomplete
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'

	-- Snippets
	use 'dcampos/nvim-snippy'
	use 'dcampos/cmp-snippy'
	use 'honza/vim-snippets'

	-- Key Bindings Hinter
	use 'folke/which-key.nvim'

	-- Incremental LSP Renaming
	use 'smjonas/inc-rename.nvim'

	-- MarkdownGlow Reader
	use 'ellisonleao/glow.nvim'

	-- OpenSCAD Support With Auto Rendering
	use 'salkin-mada/openscad.nvim'
end)
return not packer_bootstrapped
