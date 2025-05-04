set mag $argv[1]
set action $argv[2]

# check if args were provided
if not test -n "$mag"; or not test -n "$action"
    echo cant do anything without both a magazine and action
end

switch $action
    case e edit
        hx ~/magazines/$mag
end
