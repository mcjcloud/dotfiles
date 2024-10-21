active_window=$(hyprctl activewindow)
if [ "$active_window" == "Invalid" ]; then
  hyprctl dispatch workspace e-1
  exit 0
fi

active_at=$(hyprctl activewindow | grep "at: " | awk '{ print $2 }' | awk -F ',' '{ print $1 }')

if [ "$active_at" -lt 20 ]; then
  hyprctl dispatch workspace e-1
else
  hyprctl dispatch movefocus l
fi
