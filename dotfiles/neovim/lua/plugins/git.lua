return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    cmd = { 'Git', 'Gdiffsplit', 'Gvdiffsplit' },
  },

  {
    'ozelentok/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', noremap = true, desc = 'Neogit' },
    },
    opts = {}
  },

  {
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    opts = {
      signs = {
        delete    = { text = '' },
        topdelete = { text = '' },
      },
      signs_staged = {
        delete    = { text = '' },
        topdelete = { text = '' },
      }

    },
    keys = {
      {
        "<leader>gH",
        function() require("gitsigns").toggle_linehl() end,
        desc = "Toggle Line Highlight",
        mode = "n"
      },
      {
        "]h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "Next Hunk",
        mode = "n",
      },
      {
        "[h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "Prev Hunk",
        mode = "n",
      },
      { "]H",          function() require("gitsigns").nav_hunk("last") end,            desc = "Last Hunk",            mode = "n" },
      { "[H",          function() require("gitsigns").nav_hunk("first") end,           desc = "First Hunk",           mode = "n" },

      { "<leader>ghs", ":Gitsigns stage_hunk<CR>",                                     desc = "Stage Hunk",           mode = { "n", "x" } },
      { "<leader>ghr", ":Gitsigns reset_hunk<CR>",                                     desc = "Reset Hunk",           mode = { "n", "x" } },
      { "<leader>ghS", function() require("gitsigns").stage_buffer() end,              desc = "Stage Buffer",         mode = "n" },
      { "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end,           desc = "Undo Stage Hunk",      mode = "n" },
      { "<leader>ghR", function() require("gitsigns").reset_buffer() end,              desc = "Reset Buffer",         mode = "n" },

      { "<leader>ghp", function() require("gitsigns").preview_hunk_inline() end,       desc = "Preview Hunk Inline",  mode = "n" },
      { "<leader>ghb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line",           mode = "n" },
      { "<leader>ghB", function() require("gitsigns").blame() end,                     desc = "Blame Buffer",         mode = "n" },
      { "<leader>ghd", function() require("gitsigns").diffthis() end,                  desc = "Diff This",            mode = "n" },
      { "<leader>ghD", function() require("gitsigns").diffthis("~") end,               desc = "Diff This ~",          mode = "n" },

      -- Text Object (Select inside a Git Hunk)
      { "ih",          ":<C-U>Gitsigns select_hunk<CR>",                               desc = "GitSigns Select Hunk", mode = { "o", "x" } },
    },
  },

  {
    'dlyongemallo/diffview.nvim',
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
