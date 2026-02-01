# Dotfiles — WSL + WezTerm + Zellij + Claude Code

## Стек

```
Windows 11 → WezTerm → WSL2 Ubuntu 24.04 → Zellij → Bash + Claude Code
```

## Структура

```
dotfiles/
├── wsl/
│   ├── .bashrc           # Bash + автозапуск Zellij
│   └── starship.toml     # Prompt
├── wezterm/
│   └── .wezterm.lua      # WezTerm + статус Claude Code
├── zellij/
│   ├── config.kdl        # Конфиг
│   └── dev.kdl           # Layout (3 вкладки)
├── claude-hooks/
│   └── wezterm-status.sh # Hook статуса
├── scripts/
│   └── cheatsheet        # F1 шпаргалка
└── cheatsheet.md
```

## Статус-бар Claude Code

```
ctx ██░░░░ 15% │ ↓8.0K ↑17.6K │ ⚡17.7K │ $1.45 │ +476/-436 │ Opus 4.5
```

## Хоткеи

### Zellij

| Режим | Клавиша | Действия |
|-------|---------|----------|
| Панели | `Ctrl+P` | `n` новая, `x` закрыть, `w` float, `f` fullscreen, `h/j/k/l` навигация |
| Вкладки | `Ctrl+T` | `n` новая, `x` закрыть, `h/l` переключение, `1-5` по номеру |
| Ресайз | `Ctrl+N` | `h/j/k/l` размер, `+/-` больше/меньше |
| Скролл | `Ctrl+S` | `j/k` скролл, `Ctrl+D/U` полстраницы, `g/G` начало/конец |
| Сессия | `Ctrl+O` | `d` detach, `q` выход |
| — | `Ctrl+Q` | Выход |
| — | `F1` | Шпаргалка (popup) |

### WezTerm

| Клавиша | Действие |
|---------|----------|
| `Ctrl+T` | Новая вкладка |
| `Ctrl+W` | Закрыть вкладку |
| `Ctrl+Tab` | Следующая вкладка |
| `Alt+1-5` | Вкладка по номеру |
| `Ctrl+Shift+D` | Split вертикально |
| `Ctrl+Alt+D` | Split горизонтально |
| `Alt+H/J/K/L` | Навигация панелей |
| `Ctrl+Shift+Z` | Zoom панели |
| `Ctrl+Shift+C/V` | Копировать/Вставить |
| `Ctrl+Shift+F` | Поиск |
| `Ctrl++/-/0` | Шрифт |
| `Ctrl+Shift+R` | Reload конфига |
| `Ctrl+Shift+P` | Палитра команд |

### Claude Code

| Клавиша | Действие |
|---------|----------|
| `Enter` | Отправить |
| `Ctrl+C` | Прервать |
| `Ctrl+R` | История |
| `Ctrl+T` | Задачи |
| `Ctrl+G` | Внешний редактор |

| Команда | Описание |
|---------|----------|
| `/clear` | Очистить контекст |
| `/compact` | Сжать контекст |
| `/cost` | Стоимость |
| `/model` | Сменить модель |

## Rust CLI

| Команда | Заменяет |
|---------|----------|
| `rg` | grep |
| `fd` | find |
| `bat` | cat |
| `eza` | ls |
| `dust` | du |
| `procs` | ps |
| `btm` | htop |
| `sd` | sed |
| `delta` | diff |
| `z` | cd |
| `gitui` | git TUI |
| `zellij` | tmux |

## Алиасы

```bash
ll    # eza -la --icons --git
lt    # eza --tree --icons -L 2
z     # zoxide (умный cd)
```

## Установка

```bash
git clone https://github.com/moro3k/dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles && ./install.sh

# WezTerm (PowerShell)
copy \\wsl$\Ubuntu-24.04\home\ilnur\Projects\dotfiles\wezterm\.wezterm.lua $HOME\.wezterm.lua
```

## Требования

- Windows 11 + WSL2 + Ubuntu 24.04
- WezTerm
- JetBrainsMono Nerd Font
- Rust
