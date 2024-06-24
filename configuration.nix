# configuration.nix
# managed by : nixos
{ config, pkgs, ... }:

let
  gpu-drv-pkg = config.boot.kernelPackages.nvidiaPackages.stable;
in
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./colors.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "video=1920x1080" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # nix optimistation #
  nix.settings.auto-optimise-store = true;
  nix.optimise = {
    automatic = true;
    dates = [ "00:00" "12:00" "06:00" "18:00" "08:00" "20:00"];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # swap file #
  swapDevices = [{
    device = "/swapfile";
    size = 36 * 1024; # 36gb
  }];

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  # fonts
  fonts.packages = with pkgs; [
    nerdfonts
    roboto
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

  environment.pathsToLink = [ "/libexec" ];

  programs.dconf.enable = true;

  programs.zsh.enable = true;
  services.flatpak.enable = true;
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
      accent = "rosewater";
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
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    firefox
    alacritty
    killall
    zsh
  ];

  hardware.opengl = {
    enable          = true;
    driSupport32Bit = true;
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



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
