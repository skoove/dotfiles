set hour (date +%H)

function lock
    swaylock --clock --indicator $argv
end

swayidle timeout 300 "niri msg action power-off-monitors" \
    resume "niri msg action power-off-monitors" &

set sway_pid $last_pid

if test $hour -ge 21
    # if past 2100h lock to dark color
    lock -c 282828
else
    # just blur a bit otherwise
    lock --screenshot --effect-pixelate 10
end

kill $sway_pid
