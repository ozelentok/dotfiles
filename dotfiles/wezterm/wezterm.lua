local wezterm = require('wezterm')

return {
  font = wezterm.font_with_fallback({ 'Fira Code', 'Liberation Mono', 'Symbols Nerd Font', 'Noto Color Emoji' }),
  font_size = 10,
  front_end = 'WebGpu',
  max_fps = 120,
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
  check_for_updates = false,
  hide_tab_bar_if_only_one_tab = true,
  enable_scroll_bar = true,
  window_padding = {
    left = 0,
    right = 2,
    top = 0,
    bottom = 0,
  },
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = wezterm.action.Nop,
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
  keys = {
    {
      key = 'v',
      mods = 'SUPER',
      action = wezterm.action.Nop,
    },
  }
}
