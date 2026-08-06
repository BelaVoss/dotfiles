#!/bin/bash

THEME_DIR="$HOME/dotfiles/themes"
CURRENT_FILE="$HOME/.cache/theme/current"


# all themes
THEMES=($(ls "$THEME_DIR"))

# get current theme
CURRENT=$(cat "$CURRENT_FILE" 2>/dev/null)

INDEX=0

# find index
for i in "${!THEMES[@]}"; do
    if [[ "${THEMES[$i]}" == "$CURRENT" ]]; then
        INDEX=$i
    fi
done


NEXT_INDEX=$(( (INDEX + 1) % ${#THEMES[@]} ))
NEXT="${THEMES[$NEXT_INDEX]}"
echo "$NEXT" > "$CURRENT_FILE"
THEME="$THEME_DIR/$NEXT"


###########
# colors #
##########


~/dotfiles/scripts/generate-colors.sh

####################
# reload programms#
###################

# kitty
#kitty @ --to unix:/tmp/kitty set-colors \
#"$HOME/dotfiles/generated-colors/kitty.conf"

# hyprpaper
hyprctl hyprpaper wallpaper "HDMI-A-1,$THEME/wallpaper.png"
hyprctl hyprpaper wallpaper "DP-1,$THEME/wallpaper.png"

# waybar
killall -SIGUSR2 waybar

