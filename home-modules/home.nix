{ config, pkgs, inputs, osConfig , ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = "zie";
  # home.homeDirectory = "/home/zie";

  imports = [
    ../stylix.nix
    ./bottom.nix
    ./btop.nix
    ./email.nix
    ./eza.nix
    ./fish.nix
    ./floorp.nix
    ./foot.nix
    ./fuzzel.nix
    ./git.nix
    ./helix.nix
    ./magazines
    ./niri.nix
    ./nixcord.nix
    ./obs.nix
    ./rust-dev-tools.nix
    ./starship.nix
    ./stylix.nix
    ./syncthing.nix
    ./yazi.nix
    ./zellij.nix
    ./xdg.nix
    ./i3.nix
    ./iamb.nix
    ./python.nix

    inputs.stylix.homeModules.stylix
    inputs.nur.modules.homeManager.default
   ];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [
    config.stylix.fonts.monospace.name
    "DejaVu Sans"
  ];

  nix.gc = {
    automatic = osConfig.nix.gc.automatic;
    persistent = osConfig.nix.gc.persistent;
    options = osConfig.nix.gc.options;
  };
  
  home.packages = with pkgs; [
    # productive
    obsidian          # note taking
    xxd
    libreoffice-fresh # office suite
    gimp3             # image editing
    nom               # rss reader
    krita             # draw
    numbat
    stellarium
    bitwarden-desktop
    freecad-wayland
    mprocs
    jq
    wget2
    gnome-pomodoro

    # utils
    bemoji                                           # emoji picker for wofi
    brightnessctl                                    # for controlling laptop backlight
    pavucontrol                                      # volume control
    wl-clipboard                                     # Copy things to clipboard (required by bemoji)
    libsForQt5.qtstyleplugin-kvantum                 # theming for qt apps
    (import ../packages/loago.nix { inherit pkgs; }) # Shows how long ago a task was done
    mpv
    scrcpy
    porsmo             # pomodoro
    element-desktop

    # tools
    unzip
    nixd               # nix lsp
    dust               # disk usage but easier read
    nh                 # replacement for rebuild commands
    bitwarden-cli      # password manager
    sops               # secrets management
    ripgrep            # grepper
    vlc                # the last media player i will ever need
    tidal-hifi
    cargo-flamegraph   # flamegraph
    qbittorrent        # :D
    typst              # for writing school papers
    tinymist           # typst lsp
    zathura            # pdf viewer
    gh                 # gh cli
    anki-bin           # flashcards
    ckan               # komrehensive kerbal archive network
    usbutils pciutils psmisc
    nautilus
    inetutils
    mpv
    imv
    fd # better find
    xh # http request sender
    hyperfine # benchmarker

    (pkgs.inkscape-with-extensions.override {
      inkscapeExtensions = [
        pkgs.inkscape-extensions.textext
      ];
    })

    # not tools at all but i dont want to nix run them
    nitch # pretty, mostly useless
  
    # fonts
    corefonts    # ms fonts
    rubik
    inter
    roboto
    roboto-slab
    roboto-serif
  ] ++ (
    if osConfig.networking.hostName == "nixos-desktop" then with pkgs; [
      ffmpeg-full
    ] else []
  );

  programs.bat.enable = true;

  home.file = {
    ".local/share/loago/loago.json".source = config.lib.file.mkOutOfStoreSymlink /home/zie/obsidian/index/loago.json;
    ".config/inkscape/templates/default.svg".source = ../files/inkscape/default-document.svg;
    ".config/inkscape/palettes/default.gpl".source = ../files/inkscape/gruvbox-palette.gpl;
  };

  # Let Home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
