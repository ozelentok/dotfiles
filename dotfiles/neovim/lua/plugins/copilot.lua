return {
  {
    'zbirenbaum/copilot.lua',
    enabled = vim.g.dotfiles_is_developer,
    cond = vim.g.dotfiles_is_developer,
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = false,
        keymap = {
          accept = '<C-l>',
          next = '<C-j>',
          prev = '<C-k>',
          dismiss = '<C-,>',
        },
      }
    },
  },
  {
    'yetone/avante.nvim',
    enabled = vim.g.dotfiles_is_developer,
    cond = vim.g.dotfiles_is_developer,
    build = 'make',
    event = 'VeryLazy',
    version = false,
    opts = {
      instructions_file = 'avante.md',
      provider = 'copilot',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    }
  }
}
