{ pkgs, inputs, config, ... }:

{
  imports = [
    ./stylix.nix
    ./gaming.nix
    ./cybersec.nix

    inputs.stylix.nixosModules.stylix
    inputs.home-manager.nixosModules.default
    inputs.niri.nixosModules.niri
    inputs.nur.modules.nixos.default
  ];

  fileSystems."/mnt/nas" = {
    device = "192.168.0.232:/volume1/Media";
    fsType = "nfs";
    options = [ "nofail" "x-systemd.automount" "x-systemd.device-timeout=10s" ];
  };

  boot.kernelPackages = pkgs.linuxPackages;
  networking.nameservers = [ "192.168.0.254"  "1.1.1.1" "9.9.9.9" ];
  networking.networkmanager.insertNameservers = config.networking.nameservers;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.sandbox = "relaxed";

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    inputs.blender.overlays.default
  ];

  environment.sessionVariables = {
    EDITOR = "hx";
    HOSTNAME = config.networking.hostName;
    NH_FLAKE = "/home/zie/.dotfiles";
    NIXPKGS_ALLOW_UNFREE = 1;
    NIXOS_OZONE_WL=1;
  };

  programs.nh = {
    enable = true;
    flake = "/home/zie/.dotfiles";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 5 --no-gcroots --optimise";
    };
  };

  security.polkit.enable = true;

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  # opengl on
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.enableAllFirmware = true;

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


  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  programs.noisetorch.enable = true;

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  users.mutableUsers = false;
  users.users.zie = {
    isNormalUser = true;
    hashedPassword = "$6$sZqDUAAlSaboPpAR$zueEPawUgd8uvMwGNImT/HnF6t10Ct1Skrh3/caRgZZACARq7BKPGw.VQJS/uEHJoFKjyRwoKUFR78LwFQKON/";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "lp"
      "lpadmin"
      "docker"
      "wireshark"
      "keyd"
      "uinput"
      "input"
    ];
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPnGnBgccjncw0VMcpn/qjauAugKrTSzkIjLKssgVG9z zie@nixos-laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQVpPsMT/TM3XRDvhg662rUJ19PbB90FejdkYvtF8wj zie@nixos-desktop"
    ];
  };

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
    btrfs-progs
    uutils-coreutils-noprefix
    ntfs3g
    grub2 # for grub-reboot
    libnotify # just useful to be able to use from anywhere
    corefonts
    wineWowPackages.stagingFull
  ];

  programs.hyprland.enable = false;

  programs.nix-ld = {
    enable = true;
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
    autoSuspend = false;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services.protonmail-bridge.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.blueman.enable = true;
  services.tailscale.enable = true;
  services.tailscale.package = pkgs.tailscale.overrideAttrs { doCheck = false; };
  hardware.uinput.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandlePowerKey = "ignore";
    HandlePowerKeyLongPress = "ignore";
  };

  # printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr ];
  };
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = false;
    alsa.support32Bit = false;
    pulse.enable = true;
    audio.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    
    extraConfig.pipewire = {
      "10-min-quantum" = {
        "context.properties" = {
          "default.clock.min-quantum" = 1024;
        };
      };
    };
  };

  virtualisation.docker.enable = true;

  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
