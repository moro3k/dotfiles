# dotfiles

Минималистичная, быстрая конфигурация для WSL2 + WezTerm.

Все CLI-утилиты написаны на Rust — максимальная производительность.

## Что внутри

```
dotfiles/
├── .bashrc              # Bash config + aliases
├── .config/
│   └── starship.toml    # Prompt config
├── .wezterm.lua         # WezTerm config (для Windows)
└── install.sh           # Автоустановка всего
```

## Быстрый старт

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles
chmod +x install.sh
./install.sh
```

WezTerm (Windows):
```powershell
copy \\wsl$\Ubuntu-24.04\home\ilnur\Projects\dotfiles\.wezterm.lua $HOME\.wezterm.lua
```

## Установленные инструменты

### Замены стандартных утилит

| Было | Стало | Что делает |
|------|-------|------------|
| `ls` | `eza` | Иконки, git-статус, цвета |
| `cat` | `bat` | Подсветка синтаксиса |
| `grep` | `rg` | В 10x быстрее, умный |
| `find` | `fd` | Простой синтаксис, быстрый |
| `cd` | `z` | Запоминает пути |
| `du` | `dust` | Визуализация размеров |
| `ps` | `procs` | Красивый, с фильтрацией |
| `top` | `btm` | Графики, современный UI |
| `sed` | `sd` | Простой синтаксис |
| `diff` | `delta` | Side-by-side, подсветка |

### Дополнительно

| Команда | Описание |
|---------|----------|
| `starship` | Быстрый, информативный prompt |
| `atuin` | История команд с поиском (Ctrl+R) |
| `gitui` | TUI для git |
| `tokei` | Статистика кода |
| `hyperfine` | Бенчмарки команд |
| `tldr` | Примеры команд (вместо man) |
| `just` | Task runner (вместо make) |

## Алиасы

```bash
ll              # eza -la --icons --git
lt              # eza --tree --icons -L 2
la              # eza -a --icons
z <dir>         # zoxide — умный cd
```

## Хоткеи

### Bash
| Комбинация | Действие |
|------------|----------|
| `Ctrl+R` | Поиск по истории (atuin) |

### WezTerm
| Комбинация | Действие |
|------------|----------|
| `Ctrl+Shift+E` | Split горизонтально |
| `Ctrl+Shift+O` | Split вертикально |
| `Ctrl+Shift+H/J/K/L` | Навигация между панелями |
| `Ctrl+Shift+Z` | Zoom панели |
| `Ctrl+Shift+R` | Перезагрузить конфиг |

## Примеры использования

### Поиск файлов и текста
```bash
fd config                     # файлы с "config" в имени
fd -e rs                      # все .rs файлы
rg "TODO"                     # найти TODO везде
rg "fn main" -t rust          # только в Rust файлах
rg "error" -A3 -B3            # с контекстом ±3 строки
```

### Git
```bash
gitui                         # визуальный git
git diff                      # красивый diff через delta
```

### Навигация
```bash
z proj                        # прыгнуть в ~/Projects
z dot                         # прыгнуть в dotfiles
zi                            # интерактивный выбор
```

### Анализ
```bash
dust                          # что занимает место
tokei                         # строки кода по языкам
btm                           # мониторинг системы
```

## Конфигурация WezTerm

- **GPU-ускорение**: WebGpu
- **Шрифт**: JetBrainsMono Nerd Font
- **Тема**: Tokyo Night
- **Integrated titlebar** (не системный)
- **WSL по умолчанию**: Ubuntu-24.04
- **Стартовая директория**: `/home/ilnur`

## Требования

- WSL2 (Ubuntu 24.04)
- WezTerm
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)
