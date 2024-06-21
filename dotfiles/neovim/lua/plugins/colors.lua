local colors = {
  black       = '#000000',
  fg          = '#F0F0F0',
  purple      = '#D070F0',
  green       = "#30F040",
  yellow      = '#F0D020',
  cyan        = '#50E0F9',
  grey        = '#708090',
  light_grey  = '#A0C0C0',
  dark_cyan   = '#008090',
  dark_orange = '#B09000',
  diff_add    = '#003010',
  diff_delete = '#700000',
  diff_change = '#000060',
  diff_text   = '#500060',
}

return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    opts = {
      style = 'deep',
      transparent = true,
      term_colors = false,
      colors = colors,
      highlights = {
        DiffDelete = { fg = colors.gray, bg = colors.diff_delete },
        IncSearch = { fg = colors.black, bg = colors.cyan, bold = true },
        CurSearch = { fg = colors.black, bg = colors.cyan, bold = true },
        Search = { fg = colors.black, bg = colors.yellow, bold = false },
        LineNr = { fg = colors.dark_cyan },
        MatchParen = { fg = colors.black, bg = colors.purple },
        Folded = { fg = colors.cyan },
      },
      diagnostics = {
        darker = false,
        undercurl = false,
        background = true,
      },
    },
    init = function()
      vim.cmd [[colorscheme onedark]]
    end,
  },
  'hiphish/rainbow-delimiters.nvim',
  'nvim-tree/nvim-web-devicons',
  {
    'NvChad/nvim-colorizer.lua',
    events = 'VeryLazy',
    opts = {},
  },

  -- Indentation Guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = { '|', '¦', '┆' } },
    }
  },
}
