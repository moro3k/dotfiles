local wezterm = require 'wezterm'

return {

  front_end = "WebGpu",

  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    "JetBrains Mono Nerd Font",
    "JetBrainsMono Nerd Font Mono",
    "JetBrains Mono",
    "Cascadia Mono",
  }),
  font_size = 12.0,

  color_scheme = "Tokyo Night",

  -- 🔥 Интегрированный заголовок (НЕ виндовый)
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",

  window_frame = {
    font_size = 11.0,
    active_titlebar_bg = "#1a1b26",
    inactive_titlebar_bg = "#1a1b26",
  },

  window_padding = {
    left = 8,
    right = 8,
    top = 6,
    bottom = 6,
  },

  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,

  scrollback_lines = 20000,

  default_domain = "WSL:Ubuntu-24.04",
  default_cwd = "/home/ilnur",

  -- минимальные, понятные хоткеи
  keys = {
    { key = "E", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "O", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical   { domain = "CurrentPaneDomain" } },

    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Left"  },
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Up"    },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Down"  },

    { key = "Z", mods = "CTRL|SHIFT", action = "TogglePaneZoomState" },
    { key = "R", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
  },
}


