local INSTALL_TIMEOUT_MS = 1000 * 60 * 5

local parsers = {}
if vim.g.dotfiles_is_developer then
  parsers = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'regex',
    'bash', 'comment', 'cpp', 'diff', 'html',
    'javascript', 'json', 'markdown', 'python', 'yaml' }
end

vim.api.nvim_create_user_command('TSUpdateWait', function()
    local treesitter = require('nvim-treesitter')
    treesitter.install(parsers):wait(INSTALL_TIMEOUT_MS)
    treesitter.update():wait(INSTALL_TIMEOUT_MS)
  end,
  {}
)

local on_buf_read_start_treesitter = function(event)
  local bufnr = event.buf
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })

  if filetype == '' then
    return
  end

  local parser_name = vim.treesitter.language.get_lang(filetype)
  if not parser_name then
    return
  end

  local parser_configs = require('nvim-treesitter.parsers')
  if not parser_configs[parser_name] then
    return
  end

  local installed_parsers = require('nvim-treesitter.config').get_installed()
  local parser_installed = vim.tbl_contains(installed_parsers, parser_name)
  if not parser_installed then
    require('nvim-treesitter').install({ parser_name }):wait(60000)
  end

  parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
  if parser_installed then
    vim.treesitter.start(bufnr, parser_name)
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end
end

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdateWait',
  init = function()
    vim.api.nvim_create_autocmd({ 'BufRead' }, {
      callback = on_buf_read_start_treesitter
    })
  end,
}
