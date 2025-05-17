{ pkgs , ...}:
{

  services.udev = {
    enable = true;
    packages = [ pkgs.android-udev-rules ];
    extraRules = ''SUBSYSTEM=="usb", ATTR{idVendor}=="22b8", ATTR{idProduct}=="2e81", MODE="0666", GROUP="plugdev"'';
  };
}
