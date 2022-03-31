# Script: pipewire

A shell script to control pipewire with your mouse buttons and scroll wheel.

![Example](screenshots/1.png)

## Dependencies

- pipewire, pipewire-pulse
- pavucontrol
- pamixer

## Module

```ini
[module/pipewire]
type = custom/script
label = "%output%"
label-font = 2
interval = 2.0
exec = ~/.config/polybar/pipewire.sh
click-right = exec pavucontrol &
click-left = ~/.config/polybar/pipewire.sh mute &
scroll-up = ~/.config/polybar/pipewire.sh up &
scroll-down = ~/.config/polybar/pipewire.sh down &
```