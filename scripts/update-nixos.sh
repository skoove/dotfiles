sudo echo "sudoed"
sudo nixos-rebuild switch --flake ~/.dotfiles --impure |& nom
echo "nixos rebuilt"
