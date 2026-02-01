local wezterm = require 'wezterm'

local config = {
  front_end = "WebGpu",
  status_update_interval = 1000,

  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    "JetBrains Mono Nerd Font",
    "JetBrainsMono Nerd Font Mono",
    "JetBrains Mono",
    "Cascadia Mono",
  }),
  font_size = 12.0,

  color_scheme = "Tokyo Night",

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
  tab_bar_at_bottom = false,  -- Панель вкладок НАВЕРХУ

  scrollback_lines = 20000,

  default_domain = "WSL:Ubuntu-24.04",
  default_cwd = "/home/ilnur",

  keys = {
    -- ═══════════════════════════════════════════════════════════════
    -- ВКЛАДКИ (Windows-стиль)
    -- ═══════════════════════════════════════════════════════════════
    { key = "t", mods = "CTRL",       action = wezterm.action.SpawnTab "CurrentPaneDomain" },  -- Новая вкладка
    { key = "w", mods = "CTRL",       action = wezterm.action.CloseCurrentTab { confirm = true } },  -- Закрыть вкладку
    { key = "Tab", mods = "CTRL",     action = wezterm.action.ActivateTabRelative(1) },   -- Следующая вкладка
    { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) }, -- Предыдущая вкладка
    { key = "1", mods = "ALT",        action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "ALT",        action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "ALT",        action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "ALT",        action = wezterm.action.ActivateTab(3) },
    { key = "5", mods = "ALT",        action = wezterm.action.ActivateTab(4) },

    -- ═══════════════════════════════════════════════════════════════
    -- ПАНЕЛИ (СПЛИТЫ)
    -- ═══════════════════════════════════════════════════════════════
    { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },  -- Разделить вертикально |
    { key = "d", mods = "CTRL|ALT",   action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },    -- Разделить горизонтально —
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = true } },  -- Закрыть панель

    -- Навигация между панелями (Vim-стиль)
    { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Down" },

    -- Стрелки тоже работают
    { key = "LeftArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "UpArrow",    mods = "ALT", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "DownArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection "Down" },

    -- Ресайз панелей
    { key = "h", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize { "Left", 3 } },
    { key = "l", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize { "Right", 3 } },
    { key = "k", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize { "Up", 3 } },
    { key = "j", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize { "Down", 3 } },

    { key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },  -- Zoom панели

    -- ═══════════════════════════════════════════════════════════════
    -- КОПИРОВАНИЕ / ВСТАВКА / ПОИСК (Windows-стиль)
    -- ═══════════════════════════════════════════════════════════════
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "Clipboard" },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" },
    { key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search "CurrentSelectionOrEmptyString" },

    -- ═══════════════════════════════════════════════════════════════
    -- ШРИФТ
    -- ═══════════════════════════════════════════════════════════════
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

    -- ═══════════════════════════════════════════════════════════════
    -- СИСТЕМНЫЕ
    -- ═══════════════════════════════════════════════════════════════
    { key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },  -- Перезагрузить конфиг
    { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },  -- Палитра команд
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ShowDebugOverlay },  -- Debug
  },

  mouse_bindings = {
    { event = { Down = { streak = 1, button = { WheelUp = 1 } } }, mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  },
}

-- ═══════════════════════════════════════════════════════════════════
-- ЦВЕТА (Tokyo Night)
-- ═══════════════════════════════════════════════════════════════════
local colors = {
  bg = "#1a1b26",
  fg = "#c0caf5",
  blue = "#7aa2f7",
  cyan = "#7dcfff",
  green = "#9ece6a",
  yellow = "#e0af68",
  red = "#f7768e",
  magenta = "#bb9af7",
  gray = "#565f89",
  dark_gray = "#3b4261",
}

-- ═══════════════════════════════════════════════════════════════════
-- ФУНКЦИИ ДЛЯ СТАТУС-БАРА
-- ═══════════════════════════════════════════════════════════════════

local function make_bar(current, max, width)
  width = width or 10
  local ratio = math.min(current / max, 1.0)
  local filled = math.floor(ratio * width)
  local empty = width - filled

  local bar_color
  if ratio < 0.5 then
    bar_color = colors.green
  elseif ratio < 0.8 then
    bar_color = colors.yellow
  else
    bar_color = colors.red
  end

  return string.rep("█", filled) .. string.rep("░", empty), bar_color, ratio
end

local function fmt_num(n)
  if n >= 1000 then
    return string.format("%.1fK", n / 1000)
  end
  return tostring(n)
end

local function read_claude_status()
  local status_file = "\\\\wsl$\\Ubuntu-24.04\\home\\ilnur\\.claude\\wezterm-status.json"
  local f = io.open(status_file, "r")
  if not f then return nil end

  local content = f:read("*a")
  f:close()

  local ok, data = pcall(wezterm.json_parse, content)
  if not ok or not data then return nil end

  local now = os.time()
  data.stale = data.ts and (now - data.ts) > 60

  return data
end

-- ═══════════════════════════════════════════════════════════════════
-- СТАТУС-БАР (Claude Code)
-- ═══════════════════════════════════════════════════════════════════

wezterm.on("update-status", function(window, pane)
  local s = read_claude_status()
  local elements = {}

  if s and s.ctx then
    -- Определяем цвет: серый если данные устарели
    local fg = s.stale and colors.dark_gray or colors.fg
    local accent_gray = s.stale and colors.dark_gray or colors.gray
    local accent_blue = s.stale and colors.dark_gray or colors.blue
    local accent_green = s.stale and colors.dark_gray or colors.green
    local accent_cyan = s.stale and colors.dark_gray or colors.cyan
    local accent_yellow = s.stale and colors.dark_gray or colors.yellow
    local accent_red = s.stale and colors.dark_gray or colors.red
    local accent_magenta = s.stale and colors.dark_gray or colors.magenta

    -- Context bar
    local bar, bar_color = make_bar(s.ctx, 100, 6)
    if s.stale then bar_color = colors.dark_gray end
    table.insert(elements, { Foreground = { Color = accent_gray } })
    table.insert(elements, { Text = " ctx " })
    table.insert(elements, { Foreground = { Color = bar_color } })
    table.insert(elements, { Text = bar })
    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Text = string.format(" %d%% ", s.ctx) })

    -- Tokens in/out
    table.insert(elements, { Foreground = { Color = accent_gray } })
    table.insert(elements, { Text = "│" })
    table.insert(elements, { Foreground = { Color = accent_blue } })
    table.insert(elements, { Text = " ↓" .. fmt_num(s["in"]) })
    table.insert(elements, { Foreground = { Color = accent_green } })
    table.insert(elements, { Text = " ↑" .. fmt_num(s.out) .. " " })

    -- Cache
    if s.cache and s.cache > 0 then
      table.insert(elements, { Foreground = { Color = accent_gray } })
      table.insert(elements, { Text = "│" })
      table.insert(elements, { Foreground = { Color = accent_cyan } })
      table.insert(elements, { Text = " ⚡" .. fmt_num(s.cache) .. " " })
    end

    -- Cost
    if s.cost and s.cost > 0 then
      table.insert(elements, { Foreground = { Color = accent_gray } })
      table.insert(elements, { Text = "│" })
      table.insert(elements, { Foreground = { Color = accent_yellow } })
      table.insert(elements, { Text = string.format(" $%.2f ", s.cost) })
    end

    -- Lines changed
    if s.add and s.del and (s.add > 0 or s.del > 0) then
      table.insert(elements, { Foreground = { Color = accent_gray } })
      table.insert(elements, { Text = "│" })
      table.insert(elements, { Foreground = { Color = accent_green } })
      table.insert(elements, { Text = " +" .. s.add })
      table.insert(elements, { Foreground = { Color = accent_red } })
      table.insert(elements, { Text = "/-" .. s.del .. " " })
    end

    -- Model
    if s.model then
      table.insert(elements, { Foreground = { Color = accent_gray } })
      table.insert(elements, { Text = "│" })
      table.insert(elements, { Foreground = { Color = accent_magenta } })
      table.insert(elements, { Text = " " .. s.model .. " " })
    end
  end

  -- Время (всегда яркое)
  table.insert(elements, { Foreground = { Color = colors.gray } })
  table.insert(elements, { Text = "│" })
  table.insert(elements, { Foreground = { Color = colors.cyan } })
  table.insert(elements, { Text = wezterm.strftime(" %H:%M ") })

  window:set_right_status(wezterm.format(elements))
end)

return config
