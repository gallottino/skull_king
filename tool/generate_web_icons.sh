#!/usr/bin/env bash
# Rigenera le icone della PWA da assets/icons/icon_1024x1024.png.
# Richiede ImageMagick 7 (`brew install imagemagick`).
#
#   ./tool/generate_web_icons.sh
set -euo pipefail

cd "$(dirname "$0")/.."

SRC=assets/icons/icon_1024x1024.png
BG='#301C13'   # legno scuro, lo stesso di background_color nel manifest
OPT=(-strip -depth 8 -colors 256 -define png:compression-level=9)

# purpose "any": la sorgente ha gia' gli angoli arrotondati e trasparenti
magick "$SRC" -resize 192x192 "${OPT[@]}" web/icons/Icon-192.png
magick "$SRC" -resize 512x512 "${OPT[@]}" web/icons/Icon-512.png

# purpose "maskable": sfondo pieno e icona all'80%, altrimenti Android
# ritaglia il bordo dentro la sua maschera
for size in 192 512; do
  inner=$(( size * 80 / 100 ))
  magick -size "${size}x${size}" xc:"$BG" \
    \( "$SRC" -resize "${inner}x${inner}" \) -gravity center -composite \
    "${OPT[@]}" "web/icons/Icon-maskable-${size}.png"
done

# iOS: nessuna trasparenza (Safari la renderebbe nera), la maschera la mette lui
magick -size 180x180 xc:"$BG" \
  \( "$SRC" -resize 180x180 \) -gravity center -composite \
  "${OPT[@]}" web/icons/apple-touch-icon-180.png

magick "$SRC" -resize 32x32 -strip -depth 8 -colors 64 web/favicon.png

echo "Icone rigenerate in web/icons/ e web/favicon.png"
