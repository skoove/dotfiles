{ config, pkgs, inputs, osConfig , ... }:

{
  imports = [
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
    ./iamb.nix
    ./magazines
    ./niri.nix
    ./nixcord.nix
    ./nushell.nix
    ./obs.nix
    ./python.nix
    ./rust-dev-tools.nix
    ./stylix.nix
    ./syncthing.nix
    ./xdg.nix
    ./yazi.nix
    ./zellij.nix

    inputs.nur.modules.homeManager.default
   ];

  nixpkgs.overlays = [
    inputs.blender.overlays.default
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
    nix-output-monitor
    numbat
    stellarium
    bitwarden-desktop
    freecad-wayland
    mprocs
    jq
    wget
    gnome-pomodoro # pompdoro gnome
    gnome-clocks # gnome alarm
    p7zip
    aseprite

    # utils
    bemoji                                           # emoji picker for wofi
    brightnessctl                                    # for controlling laptop backlight
    pavucontrol                                      # volume control
    wl-clipboard                                     # Copy things to clipboard (required by bemoji)
    libsForQt5.qtstyleplugin-kvantum                 # theming for qt apps
    (import ../packages/loago.nix { inherit pkgs; }) # Shows how long ago a task was done
    scrcpy
    porsmo             # pomodoro
    element-desktop
    tldr # short manpage-like command instructions

    # tools
    unzip
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
    imv
    fd # better find
    xh # http request sender
    hyperfine # benchmarker
    rnote # drawing tablet optimised draw note thingy
    ov # pager


    (pkgs.inkscape-with-extensions.override {
      inkscapeExtensions = [
        pkgs.inkscape-extensions.textext
      ];
    })
    gtk3
    
    # not tools at all but i dont want to nix run them
    nitch # pretty, mostly useless
    pulseaudio
  
    # fonts
    corefonts    # ms fonts
    rubik
    inter
    roboto
    roboto-slab
    roboto-serif
  ] ++ (
    if osConfig.networking.hostName == "nixos-desktop" then with pkgs; [
      kdePackages.kdenlive
      ffmpeg-full
      blender_4_5
    ] else []
  );

  programs.bat.enable = true;

  programs.mpv = {
    enable = true;
    config = {
      ytdl-format = "bestvideo+bestaudio";
      save-position-on-quit = true;
      resume-playback = true;
      save-watch-history = true;
      idle = true;
      force-window = true;
      profile = "high-quality";
      write-filename-in-watch-later-config = true;
    };

    scripts = with pkgs.mpvScripts; [
        mpris
        uosc
        mpv-notify-send
        mpv-playlistmanager
        mpv-discord
        sponsorblock-minimal
      ];
    };

  # mpv youtube queue plugin for mpv
  home.file.".config/mpv/scripts/mpv-youtube-queue".source = pkgs.fetchurl {
    url = "https://gitea.suda.codes/sudacode/mpv-youtube-queue/raw/branch/master/mpv-youtube-queue.lua";
    hash = "sha256-LBBL1bKezTNjwSzBeD2/Lrb7Fo8wUejA1+XoJhYol40=";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    extraConfig = ''
      Host gh
        User git
        HostName github.com
      '';
    
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
  };

  services.tldr-update = {
    enable = true;
    period = "daily";
  };
  
  home.file = {
    ".local/share/loago/loago.json".source = config.lib.file.mkOutOfStoreSymlink /home/zie/obsidian/index/loago.json;
    ".config/inkscape/templates/default.svg".source = ../files/inkscape/default-document.svg;
    ".config/inkscape/palettes/default.gpl".source = ../files/inkscape/gruvbox-palette.gpl;
  };

  home.sessionVariables = {
    EDITOR="hx";
  };

  # Let Home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
