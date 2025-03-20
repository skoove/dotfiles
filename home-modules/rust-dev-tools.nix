{ pkgs , ... }:
{
  home.packages = with pkgs; [
    bacon
  ];
}
