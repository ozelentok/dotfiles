require('project_nvim').setup({})
require('nvim-treesitter.configs').setup({
	ensure_installed = 'all',
	highlight = { enable = true, disable = { 'markdown' }, additional_vim_regex_highlighting = true },
	indent = { enable = true, disable = { 'python' } }
})
require('lualine').setup({ options = { theme = 'powerline' } })
require('hop').setup()
require('indent_blankline').setup({ char_list = { '|', '¦', '┆' }, buftype_exclude = { 'terminal' } })
local neoscroll_mappings = {}
neoscroll_mappings['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '160' } }
neoscroll_mappings['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '160' } }
require('neoscroll').setup({ mappings = { '<C-u>', '<C-d>' }, hide_cursor = false, respect_scrolloff = true })
require('neoscroll.config').set_mappings(neoscroll_mappings)
require('telescope').setup({ defaults = { layout_strategy = 'bottom_pane' } })
require('telescope').load_extension('gtags')
vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal number]]
require('trouble').setup({})
vim.g.nuake_position = 'top'
require('nvim-surround').setup()
require('Comment').setup()
require('which-key').setup({})
require('inc_rename').setup({})
require('glow').setup({})
vim.diagnostic.config({ virtual_text = true })
