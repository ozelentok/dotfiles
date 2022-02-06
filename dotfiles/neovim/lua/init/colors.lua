vim.g.material_style = 'darker'
require('material').setup({
	contrast = {
		sidebars = true,
		floating_windows = true,
		line_numbers = true,
		sign_column = true,
		cursor_line = true,
		non_current_windows = false,
		popup_menu = true,
	},
	custom_colors = {
		fg = '#FFFFFF',
		bg = '#000000',
		bg_alt = '#303030',
		bg_num = '#161616',
		bg_sign = '#161616',
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
