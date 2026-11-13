#!/bin/bash

# Ermittelt automatisch den Ordner, in dem dieses Skript liegt
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Basis-Verzeichnis der Dotfiles (geht 3 Ebenen hoch von hosts/laptop/scripts)
DOTFILES_DIR="$SCRIPT_DIR/../../.."

THEMES_DIR="$DOTFILES_DIR/themes"
CURRENT_FILE="$HOME/.cache/theme/current"

# Prüfen, ob die aktuelle Theme-Datei existiert
if [ ! -f "$CURRENT_FILE" ]; then
    echo "Fehler: $CURRENT_FILE nicht gefunden!"
    exit 1
fi

CURRENT=$(cat "$CURRENT_FILE")
PALETTE="$THEMES_DIR/$CURRENT/palette.conf"

if [ ! -f "$PALETTE" ]; then
    echo "Fehler: Palette $PALETTE nicht gefunden!"
    exit 1
fi

source "$PALETTE"

# Ausgabe direkt in den Laptop-spezifischen Ordner für generierte Farben
OUT="$DOTFILES_DIR/hosts/laptop/generated-colors"
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
##############

cat > "$OUT/hyprpaper.conf" <<EOF
preload = $THEMES_DIR/$CURRENT/wallpaper.png

wallpaper {
    monitor = eDP-1 
    path = $THEMES_DIR/$CURRENT/wallpaper.png
    fit_mode = cover
}

ipc = true
EOF

echo "Farben erfolgreich für Laptop generiert unter $OUT"
