local map_vim = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local map_lua = vim.keymap.set

vim.g.mapleader = ','

-- Disable copy of selected text during paste
map_vim('x', 'p', "'pgv\"'.v:register.'y`>'", { expr = true })
map_vim('x', 'P', "'Pgv\"'.v:register.'y`>'", { expr = true })

map_vim('n', 'U', '<C-r>')

map_vim('n', '<C-h>', '<C-w>h')
map_vim('n', '<C-j>', '<C-w>j')
map_vim('n', '<C-k>', '<C-w>k')
map_vim('n', '<C-l>', '<C-w>l')

map_vim('n', '<F2>', '"=strftime("%Y-%m-%d")<CR>P')
map_vim('i', '<F2>', '<C-R>=strftime("%Y-%m-%d")<CR>')
map_vim('n', '<F3>', '"=strftime("%Y-%m-%d %H:%M:%S")<CR>P')
map_vim('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>')

map_vim('n', '<C-e>', ':Nuake<CR>')
map_vim('i', '<C-e>', '<C-\\><C-n>:Nuake<CR>')
map_vim('t', '<C-e>', '<C-\\><C-n>:Nuake<CR>')

map_vim('n', '<C-f>', ':RnvimrToggle<CR>', { silent = true })
map_vim('t', '<C-f>', '<C-\\><C-n>:RnvimrToggle<CR>', { silent = true })
map_vim('t', '<C-t>', '<C-\\><C-n>:RnvimrResize<CR>', { silent = true })

map_vim('n', 'sf', '<cmd>HopWord<CR>')
map_vim('n', 'sd', '<cmd>HopLine<CR>')
map_vim('n', 'ss', '<cmd>HopPattern<CR>')
map_vim('n', 'sa', '<cmd>HopChar1<CR>')

map_vim('n', 'sj', '<cmd>HopWordMW<CR>')
map_vim('n', 'sk', '<cmd>HopLineMW<CR>')
map_vim('n', 'sl', '<cmd>HopPatternMW<CR>')
map_vim('n', 's;', '<cmd>HopChar1MW<CR>')

map_vim('v', 'sf', '<cmd>HopWord<CR>')
map_vim('v', 'sd', '<cmd>HopLine<CR>')
map_vim('v', 'ss', '<cmd>HopPattern<CR>')
map_vim('v', 'sa', '<cmd>HopChar1<CR>')

map_vim('n', '<leader>g', '<cmd>Git|20wincmd_<CR>')
map_lua('n', '<leader>v', vim.lsp.buf.format)

map_vim('n', '<C-p>', '<cmd>Telescope find_files follow=true<CR>')
map_vim('n', '<C-o>', '<cmd>Telescope oldfiles<CR>')
map_vim('n', '<C-g>', '<cmd>Telescope git_files<CR>')
map_vim('n', '<C-s>', '<cmd>Telescope live_grep<CR>')
map_vim('n', '<C-b>', '<cmd>Telescope buffers<CR>')
map_vim('n', '<leader>c', '<cmd>Telescope command_history<CR>')
map_vim('n', '<leader>s', '<cmd>Telescope search_history<CR>')
map_vim('n', '<leader>b', '<cmd>Telescope spell_suggest initial_mode=normal<CR>')
map_vim('n', '<leader>r', '<cmd>Telescope lsp_references initial_mode=normal<CR>')
map_vim('n', '<leader>d', '<cmd>Telescope lsp_definitions initial_mode=normal<CR>')
map_vim('n', '<leader>mm', '<cmd>Telescope man_pages<CR>')
map_vim('n', '<leader>md', '<cmd>Telescope gtags def initial_mode=normal<CR>')
map_vim('n', '<leader>mr', '<cmd>Telescope gtags ref initial_mode=normal<CR>')
map_vim('n', '<leader>x', '<cmd>Telescope treesitter<CR>')

map_vim('n', '<leader>t', '<cmd>TroubleToggle document_diagnostics<CR>')
map_vim('n', '<leader>w', '<cmd>TroubleToggle workspace_diagnostics<CR>')
map_vim('n', '<leader>f', '<cmd>diffthis<CR><C-w><C-w><cmd>diffthis<CR><C-w><C-w>')

map_lua('n', '<leader>n', function() require('openscad').exec_openscad() end)

map_lua('c', '<C-e>', function()
	local escaped_command = string.gsub(vim.fn.getcmdline(), "'", "''")
	local wrapped_command = string.format("put=execute('%s')", escaped_command)
	vim.fn.setcmdline(wrapped_command)

	local enter_key = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
	vim.api.nvim_feedkeys(enter_key, 'n', true)
end)
