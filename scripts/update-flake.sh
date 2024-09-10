cd ~/.dotfiles
nix flake update ~/.dotfiles
echo "flake updated"
git commit -a -m "flake updated"
