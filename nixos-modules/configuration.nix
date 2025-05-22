{ pkgs, inputs, config, ... }:

{
  imports = [
    ../stylix.nix
    ./gaming.nix
    ./udev.nix

    inputs.stylix.nixosModules.stylix
    inputs.home-manager.nixosModules.default
    inputs.niri.nixosModules.niri
    inputs.nur.modules.nixos.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.sandbox = "relaxed";

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  environment.sessionVariables = {
    EDITOR = "hx";
    HOSTNAME = config.networking.hostName;
    NH_FLAKE = "/home/zie/.dotfiles";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  # storage optimisation
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = [ "18:00" ];
  };

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  security.polkit.enable = true;

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # opengl on
  hardware.graphics.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

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

  services.openssh.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # upower and logind
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };

  services.logind = {
    lidSwitch = "ignore";
    powerKey = "ignore";
    powerKeyLongPress = "ignore";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zie = {
    isNormalUser = true;
    description = "Zie Sturges";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      helix
    ];
  };

  # this is to make sure stylix is loaded last
  # remember to add stylix to new users
  stylix.homeManagerIntegration.autoImport = false;

  home-manager = {

    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit inputs; };

    users = {
      "zie" = import ../home-modules/home.nix;
    };
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    git
    ];

  programs.hyprland.enable = false;
  programs.nix-ld.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services.xserver.windowManager.i3.enable = false;
  services.xserver.enable = config.services.xserver.windowManager.i3.enable;

  services.xserver.displayManager.gdm.enable = true;
  
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
