vim.g.material_style = 'darker'
require('material').setup({
	contrast = true,
	borders = true,
	popup_menu = 'dark',
	italics = {comments = true},
	text_contrast = {darker = true},
	disable = {background = true},
	custom_colors = {fg = '#FFFFFF', line_numbers = '#c4a000'}
})
vim.cmd[[colorscheme material]]
require('colorizer').setup()
