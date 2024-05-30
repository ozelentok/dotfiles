return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = not vim.g.dotfiles_is_developer and {} or
          { 'c', 'lua', 'vim', 'vimdoc', 'query', 'regex',
            'bash', 'comment', 'cpp', 'diff', 'html', 'javascript',
            'json', 'markdown', 'python', 'yaml' },
      sync_install = true,
      auto_install = vim.g.dotfiles_is_developer,
      indent = { enable = true, disable = { 'python' } },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      modules = {},
      ignore_install = {},
    })
  end
}
