return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = vim.g.dotfiles_is_developer and 'all' or
          { 'c', 'lua', 'vim', 'vimdoc', 'query', 'bash', 'python', 'markdown', 'html' },
      sync_install = true,
      indent = { enable = true, disable = { 'python' } },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
    })
  end
}
