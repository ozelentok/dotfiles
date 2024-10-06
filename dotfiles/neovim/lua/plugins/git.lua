return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    cmd = { 'Git', 'Gdiffsplit', 'Gvdiffsplit' },
    keys = {
      { '<leader>c', '<cmd>Git|20wincmd_<CR>', noremap = true },
    }
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    keys = {
      { '<leader>g', '<cmd>Neogit<CR>', noremap = true },
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
