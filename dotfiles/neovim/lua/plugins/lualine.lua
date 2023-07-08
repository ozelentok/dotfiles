local colors = {
  black        = '#000000',
  white        = '#FFFFFF',
  brightyellow = '#FFFF00',
  mediumcyan   = '#70C0F0',
  darkestblue  = '#002070',
  brightred    = '#F00000',
  darkred      = '#600000',
  brightorange = '#FF9000',
  darkorange   = '#301000',
  gray1        = '#101010',
  gray4        = '#404040',
  gray8        = '#808080',
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.brightyellow, gui = 'bold' },
    b = { fg = colors.white, bg = colors.gray4 },
    c = { fg = colors.white, bg = colors.gray1 },
  },
  insert = {
    a = { fg = colors.black, bg = colors.white, gui = 'bold' },
    b = { fg = colors.black, bg = colors.mediumcyan },
    c = { fg = colors.white, bg = colors.darkestblue },
  },
  visual = {
    a = { fg = colors.black, bg = colors.brightorange, gui = 'bold' },
    c = { fg = colors.white, bg = colors.darkorange },
  },
  replace = {
    a = { fg = colors.white, bg = colors.brightred, gui = 'bold' },
    c = { fg = colors.white, bg = colors.darkred },
  },
  inactive = {
    a = { fg = colors.gray1, bg = colors.gray8, gui = 'bold' },
    b = { fg = colors.gray1, bg = colors.gray4 },
    c = { fg = colors.gray8, bg = colors.gray1 },
  },
}

theme.terminal = theme.insert

local sections = {
  lualine_a = { 'mode' },
  lualine_b = { 'branch', 'diff', 'diagnostics' },
  lualine_c = { { 'filename', path = 3 }, '%S' },
  lualine_x = { 'encoding', 'fileformat', 'filetype' },
  lualine_y = { 'progress' },
  lualine_z = { 'location' }
}

return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = { theme = theme },
    sections = sections,
    inactive_sections = sections,
  }
}
