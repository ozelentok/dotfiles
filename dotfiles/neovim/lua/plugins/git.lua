return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    cmd = { 'Git', 'Gdiffsplit', 'Gvdiffsplit' },
    keys = {
      -- { '<leader>g', '<cmd>Git|20wincmd_<CR>', noremap = true },
    }
  },

  {
    'SuperBo/fugit2.nvim',
    opts = {
      width = '90%',
      height = '80%',
      external_diffview = true,
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph', 'Fugit2Blame' },
    keys = {
      { '<leader>g', mode = 'n', '<cmd>Fugit2<CR>', noremap = true, desc = 'Fugit2' }
    }
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    keys = {
      { '<leader>c', '<cmd>Neogit<CR>', noremap = true },
    },
    opts = {}
  },

  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewFileHistory', 'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh'
    }
  },

  {
    'FabijanZulj/blame.nvim',
    cmd = { 'BlameToggle' },
    keys = {
      { '<leader>y', '<cmd>BlameToggle<CR>', noremap = true, desc = 'GitBlame' },
    },
    config = function()
      require('blame').setup({
        date_format = '%Y-%m-%d',
        max_summary_width = 50,
        format_fn = require('blame.formats.default_formats').date_message,
        merge_consecutive = true,
      })
    end,
  }
}
