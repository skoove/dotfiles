{ ... }:
{
  services.udev = {
  enable = true;
  extraRules = ''SUBSYSTEM=="usb", ATTR{idVendor}=="22b8", ATTR{idProduct}=="2e81", MODE="0666", GROUP="plugdev"'';
  };
}
