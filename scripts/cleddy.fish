# cleddy: clipboard edit
# opens clipboard in hx so you can edit it :D
set temp_file (mktemp).md

wl-paste -n >$temp_file
footclient $EDITOR $temp_file
if not test -n "cat $temp_file"
    rm $temp_file
    return
end
wl-copy <$temp_file
rm $temp_file
