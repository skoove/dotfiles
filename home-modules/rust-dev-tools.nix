{ pkgs , ... }:
{
  home.packages = with pkgs; [
    bacon
    rusty-man
    kondo # man pages byut for rust creates
  ];
}
