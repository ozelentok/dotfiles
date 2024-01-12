return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = vim.g.dotfiles_is_developer and 'all' or { 'c', 'python', 'lua', 'markdown', 'html' },
      indent = { enable = true, disable = { 'python' } },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
    })
  end
}
