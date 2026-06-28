#!/bin/bash
WALLPAPER_DIR="$HOME/backgrounds"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

CHOSEN=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | xargs -I{} basename {} \
    | sort \
    | rofi -dmenu -p " Wallpaper")

[ -z "$CHOSEN" ] && exit 0

CHOSEN_PATH="$WALLPAPER_DIR/$CHOSEN"

# Detect all connected monitors
MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

# Apply immediately via IPC
hyprctl hyprpaper preload "$CHOSEN_PATH"
for MON in $MONITORS; do
    hyprctl hyprpaper wallpaper "$MON,$CHOSEN_PATH"
done

# Save choice so it persists after reboot
{
    echo "ipc = on"
    echo "preload = $CHOSEN_PATH"
    for MON in $MONITORS; do
        echo "wallpaper = $MON,$CHOSEN_PATH"
    done
} > "$HYPRPAPER_CONF"

# Restart waybar (it sometimes hides after wallpaper change)
pkill waybar; sleep 0.3; waybar &
