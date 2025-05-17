{ ... }:
{
  xdg = {
    desktopEntries.foot = {
      name = "Open Foot in Directory";
      exec = "foot -D %U"; 
      terminal = false;
      type = "Application";
      mimeType = [ "inode/directory" ];
      noDisplay = false;
    };

    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "foot.desktop";
        "image/png" = "vlc.desktop";
        "image/jpeg" = "vlc.desktop";
      };
    };
  };
}
