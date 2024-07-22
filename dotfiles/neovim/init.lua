local tmp_dir = '/tmp/nvim'
io.popen('mkdir -p ' .. tmp_dir)
vim.o.directory = tmp_dir
vim.o.backupdir = tmp_dir
vim.o.undodir = tmp_dir
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
vim.o.expandtab = true
vim.o.mouse = 'a'
vim.o.iskeyword = 'a-z,A-Z,48-57,_,-'
vim.o.dictionary = '/usr/share/dict/words'
vim.o.modeline = false
vim.o.termguicolors = true
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.timeoutlen = 400
vim.o.diffopt = 'filler,vertical,closeoff,internal'
vim.o.shada = '!,\'500,<10,s10,h'
vim.o.showcmdloc = 'statusline'
vim.g.mapleader = ','
vim.diagnostic.config({ virtual_text = true })

vim.o.clipboard = 'unnamed,unnamedplus'
if os.getenv('SSH_TTY') then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = function() return 0 end,
      ['*'] = function() return 0 end,
    },
  }
end

dofile(vim.fn.stdpath('config') .. '/dotfiles_settings.lua')

local map_vim = function(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Semicolon enters command-line mode
map_vim('', ';', ':')

-- Capital U redo
map_vim('n', 'U', '<C-r>')

-- Replace current word
map_vim('n', '<leader>b', ':%s/<C-r><C-w>/', { desc = 'Replace current word' })

-- Window movement
map_vim('n', '<C-h>', '<C-w>h')
map_vim('n', '<C-j>', '<C-w>j')
map_vim('n', '<C-k>', '<C-w>k')
map_vim('n', '<C-l>', '<C-w>l')
map_vim('n', '<C-Right>', 'gt')
map_vim('n', '<C-Left>', 'gT')

-- Date insertion
map_vim('n', '<F2>', '"=strftime("%Y-%m-%d")<CR>P')
map_vim('i', '<F2>', '<C-R>=strftime("%Y-%m-%d")<CR>')
map_vim('n', '<F3>', '"=strftime("%Y-%m-%d %H:%M:%S")<CR>P')
map_vim('i', '<F3>', '<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>')

-- Diff two open windows
map_vim('n', '<leader>f', '<cmd>diffthis<CR><C-w><C-w><cmd>diffthis<CR><C-w><C-w>')

-- Quick exit
map_vim('n', '<C-q>', ':q<CR>')
map_vim('n', '<leader>q', ':qa<CR>')
map_vim('n', '<leader>x', ':xa<CR>')
map_vim('n', '<leader><leader>q', ':qa!<CR>')

-- Disable copy of selected text during paste
map_vim('x', 'p', "'pgv\"'.v:register.'y`>'", { expr = true })
map_vim('x', 'P', "'Pgv\"'.v:register.'y`>'", { expr = true })

-- Output command result to current buffer
vim.keymap.set('c', '<C-o>', function()
  local escaped_command = string.gsub(vim.fn.getcmdline(), "'", "''")
  local wrapped_command = string.format("put=execute('%s')", escaped_command)
  vim.fn.setcmdline(wrapped_command)

  local enter_key = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  vim.api.nvim_feedkeys(enter_key, 'n', true)
end, { noremap = true })

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
