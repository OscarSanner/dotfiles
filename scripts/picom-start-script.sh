#!/usr/bin/env sh

killall -q picom
xrdb ~/.Xresources
while pgrep -x picom >/dev/null; do sleep 1; done
picom --config ~/.config/picom/picom.conf --experimental-backends &

echo "Picom launched..."
