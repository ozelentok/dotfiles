return {
  {
    'nickjvandyke/opencode.nvim',
    enabled = vim.fn.executable('opencode') == 1,
    dependencies = {
      {
        'folke/snacks.nvim',
        opts = {
          picker = {
            actions = {
              -- Send selected item in picker to opencode
              opencode_send = function(...) return require('opencode').snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ['<C-b>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      { '<leader>jj', function() require('opencode').ask('@this: ', { submit = true }) end, desc = 'Ask opencode', mode = { 'n', 'x' } },
      { '<leader>je', function() require('opencode').select() end, desc = 'Execute opencode action…', mode = { 'n', 'x' } },
      { '<leader>jo', function() require('opencode').toggle() end, desc = 'Toggle opencode', mode = { 'n', 't' } },
      { 'go', function() return require('opencode').operator('@this ') end, desc = 'Add range to opencode', expr = true, mode = { 'n', 'x' } },
      { 'goo', function() return require('opencode').operator('@this ') .. '_' end, desc = 'Add line to opencode', expr = true },
    }
  }
}
