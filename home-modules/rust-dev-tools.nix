{ pkgs , ... }:
{
  home.packages = with pkgs; [
    bacon
    rusty-man
    kondo
  ];
}
