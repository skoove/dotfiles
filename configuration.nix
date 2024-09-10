# configuration.nix
# managed by : nixos
{ config, pkgs, ... }:

let
  gpu-drv-pkg = config.boot.kernelPackages.nvidiaPackages.stable;
in
{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./colors.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "video=1920x1080" ];

  networking.hostName = "nixos"; # Define your hostname.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # optimsation
  # nix.settings.auto-optimise-store = true;
  # nix.optimise = {
  #   automatic = true;
  # };

  # nix garbage collect 
  # i am not convinced this works *at all*
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # swap file #
  swapDevices = [{
    device = "/swapfile";
    size = 28 * 1024; # 28GiB
  }];

  # sound
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = false; # for some reason unless i explicitly disable this stuff breaks
  nixpkgs.config.pulseaudio = true;

  # fonts
  fonts.packages = with pkgs; [
    nerdfonts
    roboto roboto-slab roboto-serif
  ];

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # no clue man
  environment.pathsToLink = [ "/libexec" ];

  programs.dconf.enable = true;

  # TO DO: why is this stuff here??
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  xdg.portal.config.common.default = "*";

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "-150.0";
    };
  };

  services.displayManager.defaultSession = "none+i3";  
  
  services.xserver = {
    xkb.layout = "au";
    xkb.variant = "";
    enable = true; 
    desktopManager = {xterm.enable = false;};
    displayManager = {
      lightdm.enable = true;
      setupCommands = ''${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --primary --mode 1920x1080 --rate 100 --output DVI-I-1 --right-of HDMI-0'';
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-rounded;  
      extraPackages = with pkgs; [
        rofi
        i3lock
        picom
      ];
    };
  };

  users.defaultUserShell = pkgs.nushell;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zie = {
    isNormalUser = true;
    description = "zie";
    extraGroups = [
      "networkmanager"
      "wheel"
      "sound"
      "audio"
      "video"
    ];
  };

  catppuccin = {
      enable = true;
      accent = "lavender";
      flavor = "mocha";
    };

  # --- steam --- #
  programs.steam = {
    enable = true;
    remotePlay.openFirewall      = true;
    dedicatedServer.openFirewall = true;
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    helix
    firefox
    alacritty
    killall
    nushell
  ];

  hardware.graphics = {
    enable          = true;
    enable32Bit = true;
    package = gpu-drv-pkg;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = false;

    powerManagement = {
      enable      = false;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;
    package = gpu-drv-pkg;
  };

  system.stateVersion = "24.05";
}
