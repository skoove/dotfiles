# cleddy: clipboard edit
# opens clipboard in hx so you can edit it :D
set temp_file /tmp/$(random)

wl-paste >$temp_file
footclient hx $temp_file \; exit
wl-copy <$temp_file
