#!/bin/sh

DPI_SCALE=2    # your dpi / 96
BAR_HEIGHT=32  # polybar height
BORDER_SIZE=5  # border size from your wm settings
YAD_WIDTH=222  # 222 is minimum possible value
YAD_HEIGHT=193 # 193 is minimum possible value
DATE="$(date +"%Y-%m-%d %H:%M")"

case "$1" in
--popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
      killall -9 yad
      exit 0
    fi

    eval "$(xdotool getmouselocation --shell)"
    screen_res=$(xdpyinfo | awk '/dimensions:/ {print $2}')
    WIDTH=$(echo $screen_res | sed -e's/x.*//')
    HEIGHT=$(echo $screen_res | sed -e's/.*x//')

    # X
    if [ "$((X + DPI_SCALE * YAD_WIDTH / 2 + DPI_SCALE * BORDER_SIZE))" -gt "$WIDTH" ]; then #Right side
        : $((pos_x = WIDTH - DPI_SCALE * YAD_WIDTH - DPI_SCALE * BORDER_SIZE))
    elif [ "$((X - DPI_SCALE * YAD_WIDTH / 2 - DPI_SCALE * BORDER_SIZE))" -lt 0 ]; then #Left side
        : $((pos_x = DPI_SCALE * BORDER_SIZE))
    else #Center
        : $((pos_x = X - DPI_SCALE * YAD_WIDTH / 2))
    fi

    # Y
    if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
        : $((pos_y = HEIGHT - DPI_SCALE * YAD_HEIGHT - DPI_SCALE * BAR_HEIGHT - DPI_SCALE * BORDER_SIZE))
    else #Top
        : $((pos_y = DPI_SCALE * BAR_HEIGHT + DPI_SCALE * BORDER_SIZE))
    fi

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width="$YAD_WIDTH" --height="$YAD_HEIGHT" --posx="$pos_x" --posy="$pos_y" \
        --title="yad-calendar" --borders=0 >/dev/null &
    ;;
*)
    echo "$DATE"
    ;;
esac
