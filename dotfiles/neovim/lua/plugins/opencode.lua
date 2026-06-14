local opencode_cmd = 'opencode --port'
local snacks_terminal_opts = {
  win = {
    position = 'right',
    enter = false,
  },
}

return {
  {
    'nickjvandyke/opencode.nvim',
    enabled = vim.fn.executable('opencode') == 1,
    init = function()
      vim.g.opencode_opts = {
        server = {
          start = function()
            require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
          end,
        }
      }
    end,
    dependencies = {
      {
        'folke/snacks.nvim',
        opts = {
          picker = {
            actions = {
              -- Send selected item in picker to opencode
              opencode_send = function(picker)
                local items = vim.tbl_map(function(item)
                  return item.file
                      and require('opencode').format({ path = item.file, from = item.pos, to = item.end_pos })
                      or item.text
                end, picker:selected({ fallback = true }))

                require('opencode').prompt(table.concat(items, ', ') .. ' ')
              end,
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
      { '<leader>jo', function() require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts) end, desc = 'Toggle OpenCode', mode = { 'n', 't' } },
      { 'go', function() return require('opencode').operator('@this ') end, desc = 'Add range to opencode', expr = true, mode = { 'n', 'x' } },
      { 'goo', function() return require('opencode').operator('@this ') .. '_' end, desc = 'Add line to opencode', expr = true },
    }
  }
}
