set hour (date +%H)

function lock
    swaylock --clock --indicator $argv
end

if test $hour -ge 21
    # if past 2100h lock to dark color
    lock -c 282828
else
    # just blur a bit otherwise
    lock --screenshot --effect-pixelate 10
end
