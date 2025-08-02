local gtags_picker = function(name, gtags_option)
  return function()
    local function finder(opts, ctx)
      local tag = '.' -- Search all tags if cursor is not on word
      if ctx.filter.search ~= "" then
        tag = ctx.filter.search
      end
      return require('snacks.picker.source.proc').proc({
        opts,
        {
          cmd = 'global',
          args = { '-q', gtags_option, '--result=ctags-mod', '--', tag },
          transform = function(item)
            local _, _, path, line_number, text = string.find(item.text, '([^\t]+)\t(%d+)\t(.*)')
            local col_number = string.find(text, tag)
            item.line = text
            item.file = path
            item.pos = { tonumber(line_number, 10), col_number - 1 }
          end,
        },
      }, ctx)
    end

    Snacks.picker.pick({
      source = name,
      finder = finder,
      preview = 'file',
      need_search = true,
      search = function(picker)
        return picker:word()
      end
    })
  end
end

local gtags_definition_picker = gtags_picker('Gtags Definition', '-d')
local gtags_refrences_picker = gtags_picker('Gtags References', '-r')
local gtags_other_symbols_picker = gtags_picker('Gtags Other Symbols', '-s')

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        formats = {
          key = function(item)
            return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
          end,
        },
        sections = {
          { section = 'header' },
          { icon = '󱋡 ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = '󰪻 ', title = 'CWD Recent Files', section = 'recent_files', cwd = true, indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      explorer = { enabled = true, replace_netrw = true },
      gitbrowse = { enabled = true },
      indent = {
        enabled = true,
        indent = { char = '¦', hl = 'IblIndent' },
        animate = { enabled = false }
      },
      input = { enabled = true },
      picker = {
        enabled = true,
        reverse = true,
        layout = 'ivy'
      },
      notifier = { enabled = true, style = 'fancy' },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = {
        enabled = true,
        animate = { easing = 'inOutCirc' },
      },
    },
    keys = {
      { '<leader><space>', function() Snacks.picker.smart() end,                                                  desc = 'Smart Find Files' },
      { '<leader>b',       function() Snacks.picker.buffers() end,                                                desc = 'Buffers' },
      { '<leader>/',       function() Snacks.picker.grep() end,                                                   desc = 'Grep' },
      { '<leader>:',       function() Snacks.picker.command_history() end,                                        desc = 'Command History' },
      { '<leader>n',       function() Snacks.picker.notifications() end,                                          desc = 'Notification History' },
      { '<leader>a',       function() Snacks.explorer() end,                                                      desc = 'File Explorer' },
      -- find
      { '<leader>fb',      function() Snacks.picker.buffers() end,                                                desc = 'Buffers' },
      { '<leader>fc',      function() Snacks.picker.files({ cwd = vim.fn.stdpath('config'), follow = true }) end, desc = 'Find Config File' },
      { '<leader>ff',      function() Snacks.picker.files() end,                                                  desc = 'Find Files' },
      { '<leader>fg',      function() Snacks.picker.git_files() end,                                              desc = 'Find Git Files' },
      { '<leader>fp',      function() Snacks.picker.projects() end,                                               desc = 'Projects' },
      { '<leader>fr',      function() Snacks.picker.recent() end,                                                 desc = 'Recent' },
      -- git
      { '<leader>gb',      function() Snacks.picker.git_branches() end,                                           desc = 'Git Branches' },
      { '<leader>gl',      function() Snacks.picker.git_log() end,                                                desc = 'Git Log' },
      { '<leader>gL',      function() Snacks.picker.git_log_line() end,                                           desc = 'Git Log Line' },
      { '<leader>gs',      function() Snacks.picker.git_status() end,                                             desc = 'Git Status' },
      { '<leader>gS',      function() Snacks.picker.git_stash() end,                                              desc = 'Git Stash' },
      { '<leader>gd',      function() Snacks.picker.git_diff() end,                                               desc = 'Git Diff (Hunks)' },
      { '<leader>gf',      function() Snacks.picker.git_log_file() end,                                           desc = 'Git Log File' },
      -- Grep
      { '<leader>sb',      function() Snacks.picker.lines() end,                                                  desc = 'Buffer Lines' },
      { '<leader>sB',      function() Snacks.picker.grep_buffers() end,                                           desc = 'Grep Open Buffers' },
      { '<leader>sg',      function() Snacks.picker.grep() end,                                                   desc = 'Grep' },
      { '<leader>sw',      function() Snacks.picker.grep_word() end,                                              desc = 'Visual selection or word', mode = { 'n', 'x' } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                                              desc = 'Registers' },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                                         desc = 'Search History' },
      { '<leader>sa',      function() Snacks.picker.autocmds() end,                                               desc = 'Autocmds' },
      { '<leader>sb',      function() Snacks.picker.lines() end,                                                  desc = 'Buffer Lines' },
      { '<leader>sc',      function() Snacks.picker.command_history() end,                                        desc = 'Command History' },
      { '<leader>sC',      function() Snacks.picker.commands() end,                                               desc = 'Commands' },
      { '<leader>sd',      function() Snacks.picker.diagnostics() end,                                            desc = 'Diagnostics' },
      { '<leader>sD',      function() Snacks.picker.diagnostics_buffer() end,                                     desc = 'Buffer Diagnostics' },
      { '<leader>sh',      function() Snacks.picker.help() end,                                                   desc = 'Help Pages' },
      { '<leader>sH',      function() Snacks.pickerthighlights() end,                                             desc = 'Highlights' },
      { '<leader>si',      function() Snacks.picker.icons() end,                                                  desc = 'Icons' },
      { '<leader>sj',      function() Snacks.picker.jumps() end,                                                  desc = 'Jumps' },
      { '<leader>sk',      function() Snacks.picker.keymaps() end,                                                desc = 'Keymaps' },
      { '<leader>sl',      function() Snacks.picker.loclist() end,                                                desc = 'Location List' },
      { '<leader>sm',      function() Snacks.picker.marks() end,                                                  desc = 'Marks' },
      { '<leader>sM',      function() Snacks.picker.man() end,                                                    desc = 'Man Pages' },
      { '<leader>sp',      function() Snacks.picker.lazy() end,                                                   desc = 'Search for Plugin Spec' },
      { '<leader>st',      function() Snacks.picker.spelling() end,                                               desc = 'Spelling' },
      { '<leader>sq',      function() Snacks.picker.qflist() end,                                                 desc = 'Quickfix List' },
      { '<leader>sR',      function() Snacks.picker.resume() end,                                                 desc = 'Resume' },
      { '<leader>su',      function() Snacks.picker.undo() end,                                                   desc = 'Undo History' },
      -- LSP
      { 'gd',              function() Snacks.picker.lsp_definitions() end,                                        desc = 'Goto Definition' },
      { 'gD',              function() Snacks.picker.lsp_declarations() end,                                       desc = 'Goto Declaration' },
      { 'gr',              function() Snacks.picker.lsp_references() end,                                         nowait = true,                     desc = 'References' },
      { 'gI',              function() Snacks.picker.lsp_implementations() end,                                    desc = 'Goto Implementation' },
      { 'gy',              function() Snacks.picker.lsp_type_definitions() end,                                   desc = 'Goto T[y]pe Definition' },
      { '<leader>ss',      function() Snacks.picker.lsp_symbols() end,                                            desc = 'LSP Symbols' },
      { '<leader>sS',      function() Snacks.picker.lsp_workspace_symbols() end,                                  desc = 'LSP Workspace Symbols' },
      -- Gtags
      { '<leader>md',      gtags_definition_picker,                                                               desc = 'Gtags Definition' },
      { '<leader>mr',      gtags_refrences_picker,                                                                desc = 'Gtags References' },
      { '<leader>ms',      gtags_other_symbols_picker,                                                            desc = 'Gtags Other Symbols' },
      -- Other
      { '<leader>z',       function() Snacks.picker.zoxide() end,                                                 desc = 'Zoxide' },
      { '<leader>.',       function() Snacks.scratch() end,                                                       desc = 'Toggle Scratch Buffer' },
      { '<leader>S',       function() Snacks.scratch.select() end,                                                desc = 'Select Scratch Buffer' },
      { '<leader>nn',      function() Snacks.notifier.show_history() end,                                         desc = 'Notification History' },
      { '<leader>nt',      function() Snacks.notifier.hide() end,                                                 desc = 'Dismiss All Notifications' },
      { '<leader>cr',      function() Snacks.rename.rename_file() end,                                            desc = 'Rename File' },
      { '<leader>gB',      function() Snacks.gitbrowse() end,                                                     desc = 'Git Browse',               mode = { 'n', 'v' } },
      { ']]',              function() Snacks.words.jump(vim.v.count1) end,                                        desc = 'Next Reference',           mode = { 'n', 't' } },
      { '[[',              function() Snacks.words.jump(-vim.v.count1) end,                                       desc = 'Prev Reference',           mode = { 'n', 't' } },
    }
  },
}
