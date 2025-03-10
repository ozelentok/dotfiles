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
    },
    opts = {
      default_component_configs = {
        indent = {
          with_expanders = true,
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ["h"] = "close_node",
            ["l"] = "open",
          }
        }
      }
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

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/noice.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    keys = {
      { '<C-i>',      '<cmd>Telescope find_files follow=true<CR>',                            noremap = true },
      { '<C-p>',      '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', noremap = true },
      { '<C-o>',      '<cmd>Telescope oldfiles<CR>',                                          noremap = true },
      { '<C-g>',      '<cmd>Telescope git_files<CR>',                                         noremap = true },
      { '<C-y>',      '<cmd>Telescope buffers<CR>',                                           noremap = true },
      { '<C-s>',      '<cmd>Telescope live_grep<CR>',                                         noremap = true },
      { '<leader>ss', '<cmd>Telescope grep_string<CR>',                                       noremap = true },
      { '<leader>r',  '<cmd>Telescope lsp_references initial_mode=normal<CR>',                noremap = true },
      { '<leader>d',  '<cmd>Telescope lsp_definitions initial_mode=normal<CR>',               noremap = true },
      { '<leader>sf', '<cmd>Telescope spell_suggest initial_mode=normal<CR>',                 noremap = true },
      { '<leader>nn', '<cmd>Telescope noice<CR>',                                             noremap = true },
      { '<leader>nt', '<cmd>Telescope treesitter<CR>',                                        noremap = true },
      { '<leader>nc', '<cmd>Telescope command_history<CR>',                                   noremap = true },
      { '<leader>ns', '<cmd>Telescope search_history<CR>',                                    noremap = true },
      { '<leader>mm', '<cmd>Telescope man_pages<CR>',                                         noremap = true },
      { '<leader>md', '<cmd>Telescope gtags def initial_mode=normal<CR>',                     noremap = true },
      { '<leader>mr', '<cmd>Telescope gtags ref initial_mode=normal<CR>',                     noremap = true },
      {
        '<leader>sd',
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
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
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
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>t', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', noremap = true, desc = 'Trouble Diagnostics' },
      { '<leader>w', '<cmd>Trouble diagnostics toggle<CR>',              noremap = true, desc = 'Trouble Workspace' }
    }
  },

  -- Smooth Scrolling
  {
    'karb94/neoscroll.nvim',
    opts = {
      mappings = { '<C-u>', '<C-d>' },
      hide_cursor = false,
      respect_scrolloff = true,
      performance_mode = false,
      easing = 'circular'
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
    ft = { 'markdown' },
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
