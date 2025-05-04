{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = "zie";
  # home.homeDirectory = "/home/zie";

  imports = [
    ../stylix.nix
    ./bottom.nix
    ./email.nix
    ./eza.nix
    ./fish.nix
    ./btop.nix
    ./floorp.nix
    ./foot.nix
    ./fuzzel.nix
    ./git.nix
    ./helix.nix
    ./niri.nix
    ./nixcord.nix
    ./obs.nix
    ./rust-dev-tools.nix
    ./sops.nix
    ./starship.nix
    ./stylix.nix
    ./syncthing.nix
    ./yazi.nix
    ./zellij.nix

    inputs.stylix.homeManagerModules.stylix
   ];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [
    config.stylix.fonts.monospace.name
    "DejaVu Sans"
  ];
  
  home.packages = with pkgs; [
    # productive
    obsidian          # note taking
    libreoffice-fresh # office suite
    inkscape          # vector graphics
    gimp              # image editing
    nom               # rss reader
    blanket           # ambient noise

    # utils
    bemoji                                           # emoji picker for wofi
    brightnessctl                                    # for controlling laptop backlight
    pavucontrol                                      # volume control
    satty                                            # edit screenshots
    wl-clipboard                                     # Copy things to clipboard (required by bemoji)
    libsForQt5.qtstyleplugin-kvantum                 # theming for qt apps
    wofi-power-menu                                  # Shutdown & other power actions using wofi
    python3                                          # its python 3!
    wf-recorder                                      # screen recorder
    (import ../packages/loago.nix { inherit pkgs; }) # Shows how long ago a task was done
    gnuplot                                          # plotting lib
    mpv


    # tools
    nixd               # nix lsp
    dust               # disk usage but easier read
    nh                 # replacement for rebuild commands
    tldr               # simpler man pages
    bitwarden-cli      # password manager
    sops               # secrets management
    ripgrep            # grepper
    whatsapp-for-linux # whats
    vlc                # the last media player i will ever need
    gpodder            # nice little podcast manager
    cargo-flamegraph   # flamegraph
    qbittorrent        # :D
    typst              # for writing school papers
    tinymist           # typst lsp
    zathura            # pdf viewer
    gnome-pomodoro     # pomodoro
    gh                 # gh cli
    anki-bin           # flashcards

    # not tools at all but i dont want to nix run them
    nitch # pretty, mostly useless
    prismlauncher
    
    # fonts
    corefonts    # ms fonts
    dejavu_fonts # idk if i actually like these
    roboto
    roboto-slab
    roboto-serif
  ];

  programs.bat.enable = true;

  home.file.".local/share/loago/loago.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/zie/obsidian/index/loago.json;

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
