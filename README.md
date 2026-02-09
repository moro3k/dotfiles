# dotfiles

**Windows 11 → Alacritty → WSL2 Ubuntu → Zellij → Bash**

<img src="https://img.shields.io/badge/OS-WSL2-0078D4?style=flat-square&logo=linux&logoColor=white" alt="WSL2"> <img src="https://img.shields.io/badge/Terminal-Alacritty-F46D01?style=flat-square&logo=alacritty&logoColor=white" alt="Alacritty"> <img src="https://img.shields.io/badge/Mux-Zellij-BF4722?style=flat-square" alt="Zellij"> <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white" alt="Bash"> <img src="https://img.shields.io/badge/Theme-Tokyo%20Night-7aa2f7?style=flat-square" alt="Tokyo Night">

---

## Что внутри

```
dotfiles/
├── alacritty/
│   └── alacritty.toml       # терминал (Windows)
├── wsl/
│   ├── .bashrc              # shell + автозапуск Zellij
│   └── starship.toml        # промпт
├── zellij/
│   ├── config.kdl           # конфиг + Tokyo Night
│   └── dev.kdl              # layout: claude / dev / git
├── scripts/
│   └── cheatsheet           # F1 → hotkeys
├── hotkeys.md               # все хоткеи
└── install.sh               # установка одной командой
```

## Установка

### 1. WSL2 + Ubuntu

```powershell
# PowerShell (от администратора)
wsl --install -d Ubuntu
```

### 2. Шрифт

Скачать [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest) — распаковать, выделить все `.ttf`, ПКМ → «Установить».

### 3. Alacritty

Скачать [Alacritty](https://github.com/alacritty/alacritty/releases/latest) `.msi` и установить.

### 4. Клонируем и ставим

```bash
# В WSL:
git clone https://github.com/moro3k/dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles && ./install.sh
```

Скрипт установит: системные пакеты, Rust, cargo-binstall, Rust CLI утилиты, линки конфигов, настройку git.

### 5. Конфиг Alacritty (PowerShell)

```powershell
# Создать папку если нет
mkdir "$env:APPDATA\alacritty" -Force

# Скопировать конфиг из WSL
copy "\\wsl$\Ubuntu\home\$env:USERNAME\Projects\dotfiles\alacritty\alacritty.toml" "$env:APPDATA\alacritty\alacritty.toml"
```

### 6. Zellij

```bash
# В WSL:
cargo binstall -y zellij

# Линк конфига
mkdir -p ~/.config/zellij
ln -sf ~/Projects/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf ~/Projects/dotfiles/zellij/dev.kdl ~/.config/zellij/dev.kdl
```

Готово. Открываем Alacritty — автоматически попадаем в WSL → Zellij.

---

## Rust CLI утилиты

Современные замены стандартных команд, написанные на Rust.

| Утилита | Заменяет | Описание |
|---------|----------|----------|
| [`eza`](https://github.com/eza-community/eza) | `ls` | Иконки, git-статус |
| [`bat`](https://github.com/sharkdp/bat) | `cat` | Подсветка синтаксиса |
| [`rg`](https://github.com/BurntSushi/ripgrep) | `grep` | Быстрый поиск |
| [`fd`](https://github.com/sharkdp/fd) | `find` | Удобный поиск файлов |
| [`sd`](https://github.com/chmln/sd) | `sed` | Простые замены |
| [`dust`](https://github.com/bootandy/dust) | `du` | Размер директорий |
| [`procs`](https://github.com/dalance/procs) | `ps` | Красивый список процессов |
| [`btm`](https://github.com/ClementTsang/bottom) | `htop` | Монитор системы |
| [`delta`](https://github.com/dandavison/delta) | `diff` | Красивые диффы в git |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide) | `cd` | Умная навигация (`z`) |
| [`starship`](https://github.com/starship/starship) | prompt | Быстрый промпт |
| [`atuin`](https://github.com/atuinsh/atuin) | history | Поиск по истории |
| [`gitui`](https://github.com/extrawurst/gitui) | — | Git TUI |
| [`zellij`](https://github.com/zellij-org/zellij) | `tmux` | Мультиплексор |

### Алиасы

```bash
ll    # eza -la --icons --git
lt    # eza --tree --icons -L 2
z     # zoxide (умный cd)
cat   # bat
grep  # rg
find  # fd
```

---

## Хоткеи

### Alacritty

| Клавиша | Действие |
|---------|----------|
| `Ctrl+Shift+C/V` | Копировать / Вставить |
| `Ctrl +/-/0` | Размер шрифта |
| `Ctrl+Shift+F` | Поиск |
| `Shift+Enter` | Мультистрока в Claude Code |
| `ПКМ` | Вставить |

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

---

## Тема

**Tokyo Night** — единая цветовая схема для Alacritty и Zellij.

```
bg: #0f111a  fg: #c0caf5
```
