{ pkgs , ... }:
{
  home.packages = with pkgs; [
    bacon
    rusty-man # man pages for rust crates
    kondo # clean up crates
  ];
}
