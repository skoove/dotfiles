{ pkgs , ... }:
{
  imports = [
    ./starship.nix
  ];
  
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  
  programs.nushell = {
    enable = true;

    settings = {
      buffer_editor = "${pkgs.helix}";
    };
  };
}
