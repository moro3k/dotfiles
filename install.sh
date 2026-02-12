#!/bin/bash
set -e

echo "=== Dotfiles Installation ==="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

step() { echo -e "${BLUE}==>${NC} $1"; }
done_() { echo -e "${GREEN}[OK]${NC} $1"; }

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# 1. Install system packages
step "Installing system packages..."
sudo apt update && sudo apt install -y \
    build-essential curl wget git ca-certificates \
    unzip zip ripgrep fd-find bat jq tmux
done_ "System packages"

# 2. Create symlinks for ubuntu-named packages
step "Creating symlinks..."
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd
done_ "Symlinks"

# 3. Install Rust
if ! command -v cargo &> /dev/null; then
    step "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    done_ "Rust"
else
    done_ "Rust (already installed)"
fi

# 4. Install cargo-binstall
if ! command -v cargo-binstall &> /dev/null; then
    step "Installing cargo-binstall..."
    cargo install cargo-binstall
    done_ "cargo-binstall"
else
    done_ "cargo-binstall (already installed)"
fi

# 5. Install Rust CLI tools
step "Installing Rust CLI tools..."
source "$HOME/.cargo/env"
cargo binstall -y \
    eza zoxide starship atuin git-delta du-dust bottom \
    procs sd tokei hyperfine tealdeer gitui just
done_ "Rust CLI tools"

# 6. Link dotfiles
step "Linking dotfiles..."
ln -sf "$DOTFILES/wsl/.bashrc" ~/.bashrc
mkdir -p ~/.config
ln -sf "$DOTFILES/.config/starship.toml" ~/.config/starship.toml
done_ "Dotfiles linked"

# 7. Link tmux config
step "Linking tmux config..."
mkdir -p ~/.config/tmux
ln -sf "$DOTFILES/tmux/tmux.conf" ~/.config/tmux/tmux.conf
ln -sf "$DOTFILES/tmux/lock.conf" ~/.config/tmux/lock.conf
ln -sf "$DOTFILES/tmux/unlock.conf" ~/.config/tmux/unlock.conf
ln -sf "$DOTFILES/tmux/kbd-layout.sh" ~/.config/tmux/kbd-layout.sh
ln -sf "$DOTFILES/tmux/claude-usage.sh" ~/.config/tmux/claude-usage.sh
chmod +x "$DOTFILES/tmux/kbd-layout.sh" "$DOTFILES/tmux/claude-usage.sh"
done_ "tmux config linked"

# 8. Install TPM (tmux plugin manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    step "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    done_ "TPM installed (run Ctrl+B → I inside tmux to install plugins)"
else
    done_ "TPM (already installed)"
fi

# 9. Configure git
step "Configuring git..."
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.side-by-side true
done_ "Git configured"

echo ""
echo -e "${GREEN}=== Installation complete ===${NC}"
echo ""
echo "Restart your shell or run: source ~/.bashrc"
echo ""
echo "For Alacritty: copy alacritty.toml to Windows"
echo "  PowerShell: copy \"\\\\wsl\$\\Ubuntu\\home\\\$env:USERNAME\\Projects\\dotfiles\\alacritty\\alacritty.toml\" \"\$env:APPDATA\\alacritty\\alacritty.toml\""
echo ""
echo "Inside tmux: press Ctrl+B → I to install plugins (resurrect, yank)"
