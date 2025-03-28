# eddy: open helix then save to clipbard
set temp_file /tmp/$(random)

footclient $EDITOR $temp_file
wl-copy -n <$temp_file
rm $temp_file
