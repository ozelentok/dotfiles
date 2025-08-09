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
}
