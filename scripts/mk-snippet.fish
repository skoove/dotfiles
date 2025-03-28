# interactive markdown snippet maker
set langs rust nix markdown fish
# open fuzzel picker for langs
set lang (string replace " " \n $langs | fuzzel --dmenu)

# convert lang names to extentions
switch $lang
    case rust
        set ext rs
    case markdown
        set ext md
    case "*"
        set ext $lang
end

set temp_file (mktemp).$ext
hx $temp_file

set final_string "\
```$lang
$(cat $temp_file)
```
"

echo $final_string
wl-copy -n $final_string

rm $temp_file
