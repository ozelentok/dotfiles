io.popen('mkdir -p /tmp/nvim')
vim.o.directory = '/tmp/nvim'
vim.o.backupdir = '/tmp/nvim'
vim.o.undodir = '/tmp/nvim'
vim.o.backup = true
vim.o.undofile = true
vim.o.inccommand = 'split'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildignore = '*.swp,.bak,*.pyc,*.class,*.o,*.obj'
vim.o.wildignorecase = true
vim.o.number = true
vim.o.signcolumn = 'yes'
vim.o.scrolloff = 1
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = false
vim.o.mouse = 'a'
vim.o.iskeyword = 'a-z,A-Z,48-57,_,-'
vim.o.dictionary = '/usr/share/dict/words'
vim.o.modeline = false
vim.o.termguicolors = true
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.timeoutlen = 400
vim.o.diffopt = 'filler,vertical,closeoff,internal'
vim.o.shada = '!,\'500,<10,s10,h'
vim.g.mapleader = ','
vim.diagnostic.config({ virtual_text = true })

local map_vim = function(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
map_vim('n', '<leader>f', '<cmd>diffthis<CR><C-w><C-w><cmd>diffthis<CR><C-w><C-w>')

vim.keymap.set('c', '<C-e>', function()
  local escaped_command = string.gsub(vim.fn.getcmdline(), "'", "''")
  local wrapped_command = string.format("put=execute('%s')", escaped_command)
  vim.fn.setcmdline(wrapped_command)

  local enter_key = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  vim.api.nvim_feedkeys(enter_key, 'n', true)
end)

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')
