set commands (cat ~/magazines/L)
set command (echo $commands | fuzzel --dmenu)
footclient -H $command
