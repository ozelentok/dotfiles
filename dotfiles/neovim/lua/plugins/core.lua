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
      { '<leader>a', '<cmd>Neotree toggle<CR>', noremap = true },
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
      'folke/noice.nvim'
    },
    keys = {
      { '<C-p>',      '<cmd>Telescope find_files follow=true<CR>',              noremap = true },
      { '<C-o>',      '<cmd>Telescope oldfiles<CR>',                            noremap = true },
      { '<C-g>',      '<cmd>Telescope git_files<CR>',                           noremap = true },
      { '<C-s>',      '<cmd>Telescope live_grep<CR>',                           noremap = true },
      { '<C-b>',      '<cmd>Telescope buffers<CR>',                             noremap = true },
      { '<leader>c',  '<cmd>Telescope command_history<CR>',                     noremap = true },
      { '<leader>s',  '<cmd>Telescope search_history<CR>',                      noremap = true },
      { '<leader>b',  '<cmd>Telescope spell_suggest initial_mode=normal<CR>',   noremap = true },
      { '<leader>r',  '<cmd>Telescope lsp_references initial_mode=normal<CR>',  noremap = true },
      { '<leader>d',  '<cmd>Telescope lsp_definitions initial_mode=normal<CR>', noremap = true },
      { '<leader>n',  '<cmd>Telescope noice<CR>',                               noremap = true },
      { '<leader>mm', '<cmd>Telescope man_pages<CR>',                           noremap = true },
      { '<leader>md', '<cmd>Telescope gtags def initial_mode=normal<CR>',       noremap = true },
      { '<leader>mr', '<cmd>Telescope gtags ref initial_mode=normal<CR>',       noremap = true },
      { '<leader>x',  '<cmd>Telescope treesitter<CR>',                          noremap = true },
    },
    opts = {
      defaults = {
        layout_strategy = 'bottom_pane'
      }
    },
    init = function()
      require('telescope').load_extension('noice')
      require('telescope').load_extension('gtags')
      vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal number]]
    end,
  },

  -- Diagnostics
  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>t', '<cmd>TroubleToggle document_diagnostics<CR>',  noremap = true },
      { '<leader>w', '<cmd>TroubleToggle workspace_diagnostics<CR>', noremap = true }
    }
  },

  -- Smooth Scrolling
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
        mappings = { '<C-u>', '<C-d>' },
        hide_cursor = false,
        respect_scrolloff = true
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
    'rstacruz/vim-closer',
    event = 'VeryLazy'
  },

  -- Surrounding Pairs Actions
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy'
  },

  -- Comment Actions
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()
    end
  },

  -- Project Working Directory Management
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        scope_chdir = 'win',
        ignore_lsp = { 'lua_ls' }
      })
    end
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
      { '<leader>p', '<cmd>Glow!<CR>', noremap = true }
    },
    config = true,
  },

  -- OpenSCAD Support With Auto Rendering
  {
    'salkin-mada/openscad.nvim',
    ft = 'openscad',
    keys = {
      { '<leader>ms', function() require('openscad').exec_openscad() end, noremap = true },
    }
  },
}
