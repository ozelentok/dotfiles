local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ','

-- Disable copy of selected text during paste
map('x', 'p', "'pgv\"'.v:register.'y`>'", { expr = true })
map('x', 'P', "'Pgv\"'.v:register.'y`>'", { expr = true })

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '_', '<C-w>-')
map('n', '+', '<C-w>+')
map('n', '>', '<C-w>>')
map('n', '<', '<C-w><')

map('n', '<F2>', '"=strftime("%Y-%m-%d")<CR>P')
map('i', '<F2>', '<C-R>=strftime("%Y-%m-%d")<CR>')
map('n', '<F3>', '"=strftime("%Y-%m-%d %H:%M:%S")<CR>P')
map('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>')

map('n', '<C-q>', ':Nuake<CR>')
map('i', '<C-q>', '<C-\\><C-n>:Nuake<CR>')
map('t', '<C-q>', '<C-\\><C-n>:Nuake<CR>')

map('n', '~', ':RnvimrToggle<CR>', { silent = true })
map('t', '~', '<C-\\><C-n>:RnvimrToggle<CR>', { silent = true })
map('t', '<C-t>', '<C-\\><C-n>:RnvimrResize<CR>', { silent = true })

map('n', '<C-w>w', '<cmd>HopWord<CR>')
map('n', '<C-w>l', '<cmd>HopLine<CR>')
map('n', '<C-w>p', '<cmd>HopPattern<CR>')
map('n', '<C-w>c', '<cmd>HopChar1<CR>')
map('v', '<C-w>w', '<cmd>HopWord<CR>')
map('v', '<C-w>l', '<cmd>HopLine<CR>')
map('v', '<C-w>p', '<cmd>HopPattern<CR>')
map('v', '<C-w>c', '<cmd>HopChar1<CR>')


map('n', '<leader>g', '<cmd>Git<CR>')
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.formatting_seq_sync)

map('n', '<C-p>', '<cmd>Telescope find_files<CR>')
map('n', '<C-g>', '<cmd>Telescope git_files<CR>')
map('n', '<C-s>', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>')
map('n', '<leader>hc', '<cmd>Telescope command_history<CR>')
map('n', '<leader>hs', '<cmd>Telescope search_history<CR>')
map('n', '<leader>mp', '<cmd>Telescope man_pages<CR>')
map('n', '<leader>i', '<cmd>Telescope spell_suggest initial_mode=normal<CR>')
map('n', '<leader>r', '<cmd>Telescope lsp_references initial_mode=normal<CR>')
map('n', '<leader>d', '<cmd>Telescope lsp_definitions initial_mode=normal<CR>')
map('n', '<leader>s', '<cmd>Telescope treesitter<CR>')
map('n', '<leader>md', '<cmd>Telescope gtags def initial_mode=normal<CR>')
map('n', '<leader>mr', '<cmd>Telescope gtags ref initial_mode=normal<CR>')

map('n', '<leader>t', '<cmd>TroubleToggle document_diagnostics<CR>')
map('n', '<leader>wt', '<cmd>TroubleToggle workspace_diagnostics<CR>')
