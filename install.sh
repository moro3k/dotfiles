#!/bin/bash
set -e

echo "=== Dotfiles Installation ==="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

step() { echo -e "${BLUE}==>${NC} $1"; }
done() { echo -e "${GREEN}[OK]${NC} $1"; }

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# 1. Install system packages
step "Installing system packages..."
sudo apt update && sudo apt install -y \
    build-essential curl wget git ca-certificates \
    unzip zip ripgrep fd-find bat jq
done "System packages"

# 2. Create symlinks for ubuntu-named packages
step "Creating symlinks..."
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd
done "Symlinks"

# 3. Install Rust
if ! command -v cargo &> /dev/null; then
    step "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    done "Rust"
else
    done "Rust (already installed)"
fi

# 4. Install cargo-binstall
if ! command -v cargo-binstall &> /dev/null; then
    step "Installing cargo-binstall..."
    cargo install cargo-binstall
    done "cargo-binstall"
else
    done "cargo-binstall (already installed)"
fi

# 5. Install Rust CLI tools
step "Installing Rust CLI tools..."
source "$HOME/.cargo/env"
cargo binstall -y \
    eza zoxide starship atuin git-delta du-dust bottom \
    procs sd tokei hyperfine tealdeer gitui just
done "Rust CLI tools"

# 6. Link dotfiles
step "Linking dotfiles..."
ln -sf "$DOTFILES/.bashrc" ~/.bashrc
mkdir -p ~/.config
ln -sf "$DOTFILES/.config/starship.toml" ~/.config/starship.toml
done "Dotfiles linked"

# 7. Configure git
step "Configuring git..."
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.side-by-side true
done "Git configured"

echo ""
echo -e "${GREEN}=== Installation complete ===${NC}"
echo ""
echo "Restart your shell or run: source ~/.bashrc"
echo ""
echo "For WezTerm: copy .wezterm.lua to your Windows home directory"
echo "  cp $DOTFILES/.wezterm.lua /mnt/c/Users/\$USER/"
