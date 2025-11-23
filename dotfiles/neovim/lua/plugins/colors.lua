local colors = {
  black       = '#000000',
  fg          = '#F0F0F0',
  red         = '#F85060',
  purple      = '#D070F0',
  green       = '#30F040',
  blue        = '#41a7fc',
  yellow      = '#F0D020',
  cyan        = '#50E0F9',
  grey        = '#708090',
  light_grey  = '#A0C0C0',
  dark_cyan   = '#008090',
  dark_orange = '#B09000',
  float_bg    = '#101010',
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
        DiffDelete  = { fg = colors.gray, bg = colors.diff_delete },
        IncSearch   = { fg = colors.black, bg = colors.cyan, bold = true },
        CurSearch   = { fg = colors.black, bg = colors.cyan, bold = true },
        Search      = { fg = colors.black, bg = colors.yellow, bold = false },
        LineNr      = { fg = colors.dark_cyan },
        MatchParen  = { fg = colors.black, bg = colors.purple },
        Folded      = { fg = colors.cyan },
        FloatBorder = { bg = colors.float_bg },
        NormalFloat = { bg = colors.float_bg }
      },
      diagnostics = {
        darker = false,
        undercurl = false,
        background = true,
      },
    },
    init = function()
      vim.cmd [[colorscheme onedark]]
      local hls = {
        NeogitDiffContext          = { default = true },
        NeogitDiffContextHighlight = { default = true },
        NeogitDiffContextCursor    = { default = true },

        NeogitHunkHeader           = { fg = colors.purple, bg = '#120012', bold = true },
        NeogitHunkHeaderHighlight  = { fg = colors.purple, bg = '#240024', bold = true },
        NeogitHunkHeaderCursor     = { fg = colors.purple, bg = '#240024', bold = true },

        NeogitDiffAdd              = { fg = colors.green, bg = nil },
        NeogitDiffAddHighlight     = { fg = colors.green, bg = nil },
        NeogitDiffAddCursor        = { fg = colors.green, bg = nil },

        NeogitDiffDelete           = { fg = colors.red, bg = nil },
        NeogitDiffDeleteHighlight  = { fg = colors.red, bg = nil },
        NeogitDiffDeleteCursor     = { fg = colors.red, bg = nil },

        NeogitChangeModified       = { fg = colors.blue, bold = true },
        NeogitChangeDeleted        = { fg = colors.red, bold = true },
        NeogitChangeAdded          = { fg = colors.green, bold = true },
        NeogitChangeRenamed        = { fg = colors.yellow, italic = true },
      }
      for g, hl in pairs(hls) do
        vim.api.nvim_set_hl(0, g, hl);
      end
    end,
  },
  {
    'hiphish/rainbow-delimiters.nvim',
    submodules = false,
  },
  'nvim-tree/nvim-web-devicons',
  {
    'NvChad/nvim-colorizer.lua',
    events = 'VeryLazy',
    opts = {},
  },
}
