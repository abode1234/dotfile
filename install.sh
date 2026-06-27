#!/bin/bash

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
CONFIG="$HOME/.config"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# ~/.config/ directories to symlink
CONFIG_APPS=(hypr waybar ghostty kitty rofi nvim backgrounds fontconfig gtk-3.0 gtk-4.0)

# Home dotfiles to symlink (relative to ~)
HOME_FILES=(.zshrc .tmux.conf)

echo "Installing dotfiles..."

for app in "${CONFIG_APPS[@]}"; do
    src="$DOTFILES/.config/$app"
    dst="$CONFIG/$app"

    if [ ! -e "$src" ]; then
        echo "  skip: $app (not in dotfiles)"
        continue
    fi

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mkdir -p "$BACKUP/.config"
        mv "$dst" "$BACKUP/.config/$app"
        echo "  backed up: ~/.config/$app"
    fi

    ln -sf "$src" "$dst"
    echo "  linked: ~/.config/$app"
done

for file in "${HOME_FILES[@]}"; do
    src="$DOTFILES/$file"
    dst="$HOME/$file"

    if [ ! -e "$src" ]; then
        echo "  skip: $file (not in dotfiles)"
        continue
    fi

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/$file"
        echo "  backed up: ~/$file"
    fi

    ln -sf "$src" "$dst"
    echo "  linked: ~/$file"
done

echo ""
echo "Done. Submodules may need: git submodule update --init --recursive"
