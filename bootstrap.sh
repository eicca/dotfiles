#!/bin/bash
set -e

echo "==> Bootstrapping dotfiles..."

# Detect OS
OS="$(uname -s)"

# Install Homebrew (macOS) or essential packages (Linux)
if [ "$OS" = "Darwin" ]; then
    if ! command -v brew &> /dev/null; then
        echo "==> Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "==> Installing chezmoi..."
    brew install chezmoi
else
    echo "==> Installing chezmoi (Linux)..."
    sh -c "$(curl -fsLS get.chezmoi.io)"
fi

# Apply dotfiles
echo "==> Applying dotfiles..."
chezmoi init --apply eicca

# Install packages
if [ "$OS" = "Darwin" ]; then
    echo "==> Installing Homebrew packages..."
    brew bundle --global
fi

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "==> Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "==> Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "==> Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-vi-mode" ]; then
    echo "==> Installing zsh-vi-mode..."
    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
fi

# Create secrets file if not exists
if [ ! -f "$HOME/.secrets" ]; then
    echo "==> Creating ~/.secrets file..."
    touch "$HOME/.secrets"
    chmod 600 "$HOME/.secrets"
    echo "# Add your secrets here" >> "$HOME/.secrets"
    echo "# export OPENAI_API_KEY=..." >> "$HOME/.secrets"
fi

echo ""
echo "==> Done! Next steps:"
echo "    1. Add your API keys to ~/.secrets"
echo "    2. Restart your terminal or run: exec zsh"
echo "    3. Open nvim to install plugins: nvim"
