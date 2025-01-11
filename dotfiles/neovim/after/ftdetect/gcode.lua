vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.gcode', '*.g', '*.nc' },
  callback = function()
    vim.bo.filetype = 'gcode'
  end
})
