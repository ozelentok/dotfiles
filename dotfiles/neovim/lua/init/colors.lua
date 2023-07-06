local main_colors = {
  white        = '#FFFFFF',
  gray         = '#C0D0D0',
  black        = '#000000',
  red          = '#FF8080',
  green        = '#90F070',
  yellow       = '#FFC020',
  blue         = '#30B9FF',
  paleblue     = '#B0C9FF',
  cyan         = '#50F0FF',
  purple       = '#D090F0',
  orange       = '#F0B050',
  pink         = '#FFA0A0',
  brightred    = '#FF2020',
  brightyellow = '#F0F000',
  darkred      = '#700000',
  darkgreen    = '#003010',
  darkyellow   = '#D0A010',
  darkblue     = '#000060',
  darkcyan     = '#50C0E0',
  darkpurple   = '#500060',
  darkorange   = '#C4A000',
  darkgray     = '#303030',
}

vim.g.material_style = 'darker'
require('material').setup({
  styles = {
    keywords  = { bold = false },
    functions = { bold = true },
    operator  = { bold = true },
    types     = { bold = true },
    comments  = { italic = true },
  },
  disable = { background = true, term_colors = true },
  high_visibility = { darker = true },
  custom_colors = function(c)
    c.main                = main_colors
    c.editor.fg           = main_colors.white
    c.editor.fg_dark      = main_colors.cyan
    c.editor.line_numbers = main_colors.darkorange
    c.editor.link         = main_colors.gray

    c.syntax.variable     = c.editor.fg_dark
    c.syntax.field        = c.editor.fg
    c.syntax.keyword      = main_colors.purple
    c.syntax.value        = main_colors.yellow
    c.syntax.operator     = main_colors.cyan
    c.syntax.fn           = main_colors.blue
    c.syntax.string       = main_colors.green
    c.syntax.type         = main_colors.purple

    c.git.added           = main_colors.darkgreen
    c.git.removed         = main_colors.darkred
    c.git.modified        = main_colors.darkblue

    c.lsp.warning         = main_colors.brightyellow
    c.lsp.error           = main_colors.brightred
    c.lsp.info            = main_colors.paleblue
    c.lsp.hint            = main_colors.darkcyan
  end,
  custom_highlights = (function()
    local hls = {}
    hls['Number'] = { fg = main_colors.yellow, bold = false }
    hls['Boolean'] = { fg = main_colors.darkorange, bold = true }
    hls['@type'] = { fg = main_colors.purple, bold = true }
    hls['@type.builtin'] = { fg = main_colors.purple, bold = true }
    hls['@type.qualifier'] = { fg = main_colors.yellow, bold = true }
    hls['@operator'] = { fg = main_colors.cyan, bold = true }
    hls['@attribute'] = { fg = main_colors.paleblue, bold = false }
    hls['@namespace'] = { fg = main_colors.pink, bold = false }
    hls['CursorLine'] = { bg = main_colors.darkgray, bold = true }
    hls['CursorColumn'] = { bg = main_colors.darkgray, bold = true }
    hls['DiffAdd'] = { bg = main_colors.darkgreen, reverse = false }
    hls['DiffDelete'] = { fg = main_colors.gray, bg = main_colors.darkred, reverse = false }
    hls['DiffChange'] = { bg = main_colors.darkblue, reverse = false }
    hls['DiffText'] = { bg = main_colors.darkpurple, reverse = false }
    hls['diffAdded'] = { link = 'DiffAdd' }
    hls['diffRemoved'] = { link = 'DiffDelete' }
    hls['IncSearch'] = { fg = main_colors.black, bg = main_colors.cyan, bold = true }
    hls['CurSearch'] = { fg = main_colors.black, bg = main_colors.cyan, bold = true }
    hls['Search'] = { fg = main_colors.black, bg = main_colors.yellow, bold = false }
    return hls
  end)()
})

vim.cmd [[colorscheme material]]

require('colorizer').setup({})
