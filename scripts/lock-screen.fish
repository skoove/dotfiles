set hour (date +%H)

function lock
    swaylock $argv
end

swayidle timeout 300 "niri msg action power-off-monitors" \
    resume "niri msg action power-off-monitors" &

set sway_pid $last_pid

lock --screenshot --effect-blur 5x5

kill $sway_pid
