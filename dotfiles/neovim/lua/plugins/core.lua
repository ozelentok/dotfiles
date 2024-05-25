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

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>a', '<cmd>Neotree toggle<CR>', noremap = true, desc = 'Neotree' },
    }
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
    config = function()
      require('hop').setup()
    end
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

  -- Drop Down Terminal
  {
    'Lenovsky/nuake',
    keys = {
      { '<C-e>', ':Nuake<CR>',            noremap = true },
      { '<C-e>', '<C-\\><C-n>:Nuake<CR>', noremap = true, mode = 'i' },
      { '<C-e>', '<C-\\><C-n>:Nuake<CR>', noremap = true, mode = 't' },
    },
    init = function()
      vim.g.nuake_position = 'top'
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/noice.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    keys = {
      { '<C-p>',      '<cmd>Telescope find_files follow=true<CR>',                noremap = true },
      { '<C-p><C-p>', '<cmd>Telescope find_files follow=true no_ignore=true<CR>', noremap = true },
      { '<C-o>',      '<cmd>Telescope oldfiles<CR>',                              noremap = true },
      { '<C-g>',      '<cmd>Telescope git_files<CR>',                             noremap = true },
      { '<C-b>',      '<cmd>Telescope buffers<CR>',                               noremap = true },
      { '<C-s>',      '<cmd>Telescope live_grep<CR>',                             noremap = true },
      { '<C-s><C-s>', '<cmd>Telescope grep_string<CR>',                           noremap = true },
      { '<leader>s',  '<cmd>Telescope spell_suggest initial_mode=normal<CR>',     noremap = true },
      { '<leader>r',  '<cmd>Telescope lsp_references initial_mode=normal<CR>',    noremap = true },
      { '<leader>d',  '<cmd>Telescope lsp_definitions initial_mode=normal<CR>',   noremap = true },
      { '<leader>n',  '<cmd>Telescope noice<CR>',                                 noremap = true },
      { '<leader>x',  '<cmd>Telescope treesitter<CR>',                            noremap = true },
      { '<leader>hc', '<cmd>Telescope command_history<CR>',                       noremap = true },
      { '<leader>hs', '<cmd>Telescope search_history<CR>',                        noremap = true },
      { '<leader>mm', '<cmd>Telescope man_pages<CR>',                             noremap = true },
      { '<leader>md', '<cmd>Telescope gtags def initial_mode=normal<CR>',         noremap = true },
      { '<leader>mr', '<cmd>Telescope gtags ref initial_mode=normal<CR>',         noremap = true },
      {
        '<C-s><C-d>',
        function()
          require('telescope.builtin').live_grep({
            additional_args = { '--no-ignore' }
          })
        end,
        noremap = true,
        desc = 'Telescope live_grep --no-ignore'
      },
    },
    opts = {
      defaults = {
        layout_strategy = 'bottom_pane'
      }
    },
    init = function()
      require('telescope').load_extension('noice')
      require('telescope').load_extension('gtags')
      require('telescope').load_extension('fzf')
      vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal number]]
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },

  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    },
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
    keys = {
      { '<leader>t', '<cmd>TroubleToggle document_diagnostics<CR>',  noremap = true, desc = 'Trouble Diagnostics' },
      { '<leader>w', '<cmd>TroubleToggle workspace_diagnostics<CR>', noremap = true, desc = 'Trouble Workspace' }
    }
  },

  -- Smooth Scrolling
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
        mappings = { '<C-u>', '<C-d>' },
        hide_cursor = false,
        respect_scrolloff = true,
        performance_mode = false,
      })
      require('neoscroll.config').set_mappings({
        ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '160' } },
        ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '160' } },
      })
    end
  },

  -- Git
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    cmd = { 'Git', 'Gdiffsplit', 'Gvdiffsplit' },
    keys = {
      { '<leader>g', '<cmd>Git|20wincmd_<CR>' },
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
    config = function()
      require('which-key').setup()
    end
  },

  -- MarkdownGlow Reader
  {
    'ellisonleao/glow.nvim',
    ft = 'markdown',
    keys = {
      { '<leader>p', '<cmd>Glow!<CR>', noremap = true, desc = 'Markdown Glow', ft = 'markdown' }
    },
    config = true,
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

  -- Copy over remote SSH connections
  {
    'ojroques/nvim-osc52',
    config = function()
      require('osc52').setup()
    end,
    keys = {
      {
        '<leader>y',
        function()
          return require('osc52').copy_operator()
        end,
        noremap = true,
        expr = true,
        desc = 'OSC52 Copy Operator'
      },
      {
        '<leader>y',
        function() require('osc52').copy_visual() end,
        noremap = true,
        mode = 'v',
        desc = 'OSC52 Copy Line'
      },
      { '<leader>yy', '<leader>y_', remap = true, desc = 'OSC52 Copy Line' },
    }
  }
}
