vim.g.material_style = 'darker'
require('material').setup({
	contrast = {
		sidebars = true,
		floating_windows = true,
		cursor_line = true,
		non_current_windows = false,
	},
	custom_colors = function (colors)
			colors.editor.fg = '#FFFFFF'
			colors.editor.fg_dark = '#FFFFFF'
			colors.editor.bg = '#000000'
			colors.editor.bg_alt = '#202020'
			colors.editor.line_numbers = '#c4a000'
			colors.backgrounds.non_current_windows = 'NONE'
	end,
	high_visibility = {
		darker = true
	},
	disable = {
		background = true
	},
})
vim.cmd [[colorscheme material]]
require('colorizer').setup({})
