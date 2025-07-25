# -- utils -- #

function new_foot
    footclient $argv & disown
end

function notif
    notify-send magazines "$argv"
end

function cancel_checker
    if test "$argv" = "!cancel"
        notif canceled
        exit
    end
end

# -- entry point -- #
set mag $argv[1]
set action $argv[2]
set mag_path /home/zie/magazines/$mag

# check if args were provided
if not test -n "$mag"; or not test -n "$action"
    notif cant do anything without both a magazine and action
end

switch $action
    case e edit
        notif editing magazine: $mag
        new_foot hx $mag_path

    case v view
        notif viewing magazine: $mag
        new_foot $PAGER $mag_path

    case c copy
        switch $mag
            # special behaviour
            # split some things at the first instance of — (U+2014) then copy stuff after that
            case l s d
                set selected (cat $mag_path | fuzzel --dmenu)
                set thing_to_copy (string split — $selected --max 1)[2]
                set thing_to_copy (string trim $thing_to_copy)
                wl-copy $thing_to_copy
                notif copied \"$thing_to_copy\"

            case "*"
                set selected (cat $mag_path | fuzzel --dmenu)
                wl-copy $selected
                notif copied \"$selected\"

        end

    case a append
        switch $mag
            # special behaviour:
            # allow for input of headers then the contents
            # good for stuff like links and symbols
            # in file headers and contents are seperated by — (U+2014)
            case l s d
                set header (fuzzel --dmenu --prompt 'title: ')
                cancel_checker $header
                set contents (fuzzel --dmenu --prompt 'body: ')
                cancel_checker $header
                set item "$header — $contents"
                echo $item >>$mag_path
                notif appended \"$item\" to magazine: $mag

            case "*"
                set input (fuzzel --dmenu)
                cancel_checker $input
                echo $input >>$mag_path
                notif appended \"$input\" to magazine: $mag
        end

    case "*"
        notif invalid action: $action
end

keydctl layer main
