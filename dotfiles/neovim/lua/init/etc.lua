require('nvim-treesitter.configs').setup({
	ensure_installed = 'all',
	highlight = {enable = true, disable = {'markdown'}, additional_vim_regex_highlighting = true},
	indent = {enable = true, disable = {'python'}}
})

vim.g.nuake_position = 'top'
require('lualine').setup({options = {theme = 'powerline'}})
require('hop').setup()
require('indent_blankline').setup({char_list = {'|', '¦', '┆'}, buftype_exclude = {'terminal'}})
vim.diagnostic.config({virtual_text = true})

local neoscroll_mappings = {}
neoscroll_mappings['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '160'}}
neoscroll_mappings['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '160'}}
require('neoscroll').setup({mappings={'<C-u>', '<C-d>'}, hide_cursor = false, respect_scrolloff = true})
require('neoscroll.config').set_mappings(neoscroll_mappings)

require('trouble').setup({})
require('telescope').setup({defaults = {layout_strategy = 'bottom_pane'}})
require('telescope').load_extension('gtags')
vim.cmd[[autocmd User TelescopePreviewerLoaded setlocal number]]
