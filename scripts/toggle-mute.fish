#!/usr/bin/env fish

set source (pactl get-default-source)
set muted (pactl get-source-mute $source | awk '{print $2}')

echo $source
echo $muted

if test $muted = yes
    pactl set-source-mute $source 0
    dunstify unmuted $source
else
    pactl set-source-mute $source 1
    dunstify muted $source
end
