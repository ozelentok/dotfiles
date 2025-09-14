return {
  -- UI
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        signature = {
          enabled = false,
        }
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = false,
      },
    },
  },

  -- Movement
  {
    'phaazon/hop.nvim',
    keys = {
      { 'sf', '<cmd>HopWord<CR>',      noremap = true },
      { 'sd', '<cmd>HopLine<CR>',      noremap = true },
      { 'ss', '<cmd>HopPattern<CR>',   noremap = true },
      { 'sa', '<cmd>HopChar1<CR>',     noremap = true },
      { 'sf', '<cmd>HopWord<CR>',      noremap = true, mode = 'v' },
      { 'sd', '<cmd>HopLine<CR>',      noremap = true, mode = 'v' },
      { 'ss', '<cmd>HopPattern<CR>',   noremap = true, mode = 'v' },
      { 'sa', '<cmd>HopChar1<CR>',     noremap = true, mode = 'v' },
      { 'sj', '<cmd>HopWordMW<CR>',    noremap = true },
      { 'sk', '<cmd>HopLineMW<CR>',    noremap = true },
      { 'sl', '<cmd>HopPatternMW<CR>', noremap = true },
      { 's;', '<cmd>HopChar1MW<CR>',   noremap = true },
    },
    opts = {}
  },

  -- Ranger Intergration
  {
    'kevinhwang91/rnvimr',
    keys = {
      { '<C-f>', ':RnvimrToggle<CR>',            noremap = true, silent = true },
      { '<C-f>', '<C-\\><C-n>:RnvimrToggle<CR>', noremap = true, silent = true, mode = 't' },
      { '<C-t>', '<C-\\><C-n>:RnvimrResize<CR>', noremap = true, silent = true, mode = 't' },
    }
  },

  {
    'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = [[<c-e>]],
    }
  },

  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>e',
        function()
          require('dropbar.api').pick()
        end,
        noremap = true,
        desc = 'Select dropbar'
      },
    },
  },

  -- Diagnostics
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>tt', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', noremap = true, desc = 'Trouble Diagnostics' },
      { '<leader>ww', '<cmd>Trouble diagnostics toggle<CR>',              noremap = true, desc = 'Trouble Workspace' }
    }
  },

  -- Automatic Brackets Closer
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Surrounding Pairs Actions
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {},
  },

  -- Project Working Directory Management
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        scope_chdir = 'win',
        ignore_lsp = { 'lua_ls' },
        manual_mode = true,
        silent_chdir = false,
      })
    end,
    keys = {
      {
        '<leader>i',
        function()
          vim.o.autochdir = false
          require('project_nvim.project').on_buf_enter()
          vim.print('ProjectRoot enabled')
        end,
        noremap = true,
        desc = 'CD to project directory'
      },
      {
        '<leader>u',
        function()
          vim.cmd('lcd ' .. vim.fn.expand('%:p:h'))
          vim.o.autochdir = true
          vim.print('autochir enabled')
        end,
        noremap = true,
        desc =
        'Enable auto file working directory'
      },
      {
        '<leader>U',
        function()
          vim.o.autochdir = false
          vim.print('autochir disabled')
        end,
        noremap = true,
        desc =
        'Disable auto file workspace directory'
      },
    }
  },

  -- Key Bindings Hinter
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
  },

  -- Search Replace
  {
    'nvim-pack/nvim-spectre',
    event = 'VeryLazy',
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    ft = { 'markdown', 'Avante' },
    keys = {
      {
        '<leader>p',
        function() require('render-markdown').toggle() end,
        noremap = true,
        ft = 'markdown'
      }
    },
  },

  -- OpenSCAD Support With Auto Rendering
  {
    'salkin-mada/openscad.nvim',
    ft = 'openscad',
    keys = {
      {
        '<leader>p',
        function() require('openscad').exec_openscad() end,
        noremap = true,
        desc = 'OpenSCAD',
        ft = 'openscad'
      },
    }
  },

  -- GDB Integration
  {
    'sakhnik/nvim-gdb',
    events = 'VeryLazy',
    opts = {}
  },
}
