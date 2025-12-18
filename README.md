# Dotfiles

My dotfiles managed with [chezmoi](https://chezmoi.io).

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/eicca/dotfiles/master/bootstrap.sh | bash
```

## What's Included

- **Neovim** - LSP, blink.cmp, telescope, treesitter
- **Zsh** - oh-my-zsh, starship prompt, vi-mode, syntax highlighting
- **WezTerm** - terminal config
- **CLI tools** - eza, bat, fd, ripgrep, fzf, delta, yazi

## Manual Setup

```bash
# Install chezmoi and apply
chezmoi init --apply eicca

# Install brew packages (macOS)
brew bundle --global

# Install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
```

## Update

```bash
chezmoi update
```
