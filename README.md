# dotfiles

**Windows 11 → Alacritty → WSL2 Ubuntu → tmux → Bash**

<img src="https://img.shields.io/badge/OS-WSL2-0078D4?style=flat-square&logo=linux&logoColor=white" alt="WSL2"> <img src="https://img.shields.io/badge/Terminal-Alacritty-F46D01?style=flat-square&logo=alacritty&logoColor=white" alt="Alacritty"> <img src="https://img.shields.io/badge/Mux-tmux-1BB91F?style=flat-square" alt="tmux"> <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white" alt="Bash"> <img src="https://img.shields.io/badge/Theme-Tokyo%20Night-7aa2f7?style=flat-square" alt="Tokyo Night">

---

## Что внутри

```
dotfiles/
├── alacritty/
│   └── alacritty.toml       # терминал (Windows)
├── tmux/
│   ├── tmux.conf             # Zellij-like конфиг
│   ├── lock.conf             # режим блокировки
│   ├── unlock.conf           # разблокировка
│   ├── kbd-layout.sh         # индикатор раскладки RU/EN
│   └── claude-usage.sh       # лимиты Claude API (опционально)
├── wsl/
│   ├── .bashrc               # shell
│   └── starship.toml         # промпт
├── scripts/
│   └── cheatsheet            # hotkeys
├── hotkeys.md                # все хоткеи
└── install.sh                # установка
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
git clone https://github.com/moro3k/dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles && ./install.sh
```

### 5. Конфиг Alacritty (PowerShell)

```powershell
mkdir "$env:APPDATA\alacritty" -Force
copy "\\wsl$\Ubuntu\home\$env:USERNAME\Projects\dotfiles\alacritty\alacritty.toml" "$env:APPDATA\alacritty\alacritty.toml"
```

Готово. Открываем Alacritty — автоматически попадаем в WSL → tmux.

---

## tmux (Zellij-like)

Модальные режимы как в Zellij, подсказки по центру статусбара, раскладка и время справа.

### Режимы

| Вход | Режим | Подсказки |
|------|-------|-----------|
| `Ctrl+P` | PANE | `d` ↓  `r` →  `x` ✕  `f` zoom  `←→` nav  `Esc` |
| `Ctrl+T` | TAB | `n` new  `x` ✕  `r` ren  `←→` sw  `1-5` go  `Esc` |
| `Ctrl+O` | SESS | `d` det  `w` list  `r` ren  `Esc` |
| `Ctrl+G` | LOCK | Отключает все хоткеи. `Ctrl+G` — unlock |

### Быстрые клавиши

| Клавиша | Действие |
|---------|----------|
| `Alt+1..5` | Переключить/создать вкладку |
| `Ctrl+B \|` | Сплит горизонтально |
| `Ctrl+B -` | Сплит вертикально |
| `Ctrl+B → Ctrl+S` | Сохранить сессию (resurrect) |
| `Ctrl+B → Ctrl+R` | Восстановить сессию |

### Мышь

| Действие | Результат |
|----------|-----------|
| Выделение | Копирует в буфер (tmux + системный через tmux-yank) |
| Средняя кнопка | Вставить из буфера |
| ПКМ | Контекстное меню tmux |
| Колёсико | Скролл |

### Русская раскладка

Все `Ctrl+` комбинации работают и в русской раскладке.

### Плагины

- **tmux-resurrect** — сохранение/восстановление сессий
- **tmux-yank** — копирование в системный буфер

---

## Rust CLI утилиты

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

## Тема

**Tokyo Night** — единая цветовая схема для Alacritty и tmux.

```
bg: #0f111a  fg: #c0caf5
```
