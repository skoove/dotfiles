# eddy: open helix then save to clipbard
set temp_file (mktemp).md

footclient $EDITOR $temp_file
if not test -n "cat $temp_file"
    rm $temp_file
    return
end
wl-copy -n <$temp_file
rm $temp_file
