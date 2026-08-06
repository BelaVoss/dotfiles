#!/bin/bash

THEMES_DIR="$HOME/dotfiles/themes"
CURRENT_FILE="$HOME/.cache/theme/current"

CURRENT=$(cat "$CURRENT_FILE")

PALETTE="$THEMES_DIR/$CURRENT/palette.conf"

source "$PALETTE"

OUT="$HOME/dotfiles/generated-colors"
mkdir -p "$OUT"


##########
# Kitty #
#########

cat > "$OUT/kitty.conf" <<EOF
background $background
foreground $foreground
EOF


##############
# hyprpaper #
#############

cat > "$OUT/hyprpaper.conf" <<EOF
preload = $THEMES_DIR/$CURRENT/wallpaper.png

wallpaper {
    monitor = HDMI-A-1
    path = $THEMES_DIR/$CURRENT/wallpaper.png
    fit_mode = cover
}

wallpaper {
    monitor = DP-1
    path = $THEMES_DIR/$CURRENT/wallpaper.png
    fit_mode = cover
}

ipc = true
EOF
