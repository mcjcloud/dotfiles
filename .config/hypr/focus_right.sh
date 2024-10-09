active_window=$(hyprctl activewindow)
if [ "$active_window" == "Invalid" ]; then
  hyprctl dispatch workspace e+1
  exit 0
fi

active_at=$(hyprctl activewindow | grep "at: " | awk '{ print $2 }' | awk -F ',' '{ print $1 }')
active_width=$(hyprctl activewindow | grep "size: " | awk '{ print $2 }' | awk -F ',' '{ print $1 }')
active_edge=$(($active_at + $active_width))

if [ "$active_edge" -gt 1580 ]; then
  hyprctl dispatch workspace e+1
else
  hyprctl dispatch movefocus r
fi
