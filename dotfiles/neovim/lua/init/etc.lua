require('nvim-treesitter.configs').setup({
	ensure_installed = 'maintained',
	highlight = {enable = true, additional_vim_regex_highlighting = false},
	indent = {enable = true}
})
require('lualine').setup({options = {theme = 'material'}})
require('hop').setup()
require('indent_blankline').setup({char_list = {'|', '¦', '┆'}, buftype_exclude = {'terminal'}})

local neoscroll_mappings = {}
neoscroll_mappings['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '160'}}
neoscroll_mappings['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '160'}}
require('neoscroll').setup({mappings={'<C-u>', '<C-d>'}, hide_cursor = false, respect_scrolloff = true})
require('neoscroll.config').set_mappings(neoscroll_mappings)

require('telescope').setup({defaults = {layout_strategy = 'bottom_pane'}})
require('trouble').setup({})
vim.g.nuake_position = 'top'

require('formatter').setup({
	filetype = {
		python = {function() return {exe = 'yapf', stdin = true} end},
	}
})
require('telescope').load_extension('gtags')