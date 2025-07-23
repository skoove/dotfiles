set command (cat ~/magazines/L| fuzzel --dmenu)
set output_file (mktemp)
footclient fish -c "$command >$output_file"

nnotify-send "command runner output:" "$(cat $output_file)"
