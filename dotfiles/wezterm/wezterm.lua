local wezterm = require('wezterm')

return {
  font = wezterm.font('Hack Nerd Font'),
  font_size = 10.5,
  colors = {
    foreground = 'white',
    background = 'black',
    cursor_bg = 'white',
    ansi = {
      '#000000',
      '#e10000',
      '#00ee00',
      '#cdcd00',
      '#0080ff',
      '#cd00cd',
      '#00cdcd',
      '#e5e5e5',
    },
    brights = {
      '#7f7f7f',
      '#ff0000',
      '#00ff00',
      '#ffff00',
      '#00b0ff',
      '#ff00ff',
      '#00ffff',
      '#ffffff',
    },
  },
  hide_tab_bar_if_only_one_tab = true,
  enable_scroll_bar = true,
  window_padding = {
    left = 0,
    right = 2,
    top = 0,
    bottom = 0,
  },
}
