# eddy: open helix then save to clipbard
set temp_file (mktemp)

footclient $EDITOR $temp_file
wl-copy -n <$temp_file
rm $temp_file
