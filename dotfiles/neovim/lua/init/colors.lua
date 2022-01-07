vim.g.material_style = 'darker'
require('material').setup({
	custom_colors = {
		fg = '#FFFFFF',
		line_numbers = '#c4a000'
	},
	high_visibility = {
		darker = true
	},
	disable = {
		background = true
	},
})
vim.cmd[[colorscheme material]]
require('colorizer').setup()
