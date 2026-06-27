#!/bin/bash
WALLPAPER_DIR="$HOME/backgrounds"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

CHOSEN=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | xargs -I{} basename {} \
    | sort \
    | rofi -dmenu -p " Wallpaper")

[ -z "$CHOSEN" ] && exit 0

CHOSEN_PATH="$WALLPAPER_DIR/$CHOSEN"

# Apply immediately via IPC
hyprctl hyprpaper preload "$CHOSEN_PATH"
hyprctl hyprpaper wallpaper "HDMI-A-1,$CHOSEN_PATH"

# Save choice so it persists after reboot
cat > "$HYPRPAPER_CONF" << EOF
ipc = on
preload = $CHOSEN_PATH
wallpaper = HDMI-A-1,$CHOSEN_PATH
EOF

# Restart waybar (it sometimes hides after wallpaper change)
pkill waybar; sleep 0.3; waybar &
