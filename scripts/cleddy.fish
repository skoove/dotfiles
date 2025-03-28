# cleddy: clipboard edit
# opens clipboard in hx so you can edit it :D
set temp_file /tmp/$(random)

wl-paste -n >$temp_file
footclient $EDITOR $temp_file
wl-copy <$temp_file
rm $temp_file
