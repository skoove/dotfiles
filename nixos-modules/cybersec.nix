{ pkgs , ... }:
{
  environment.systemPackages = with pkgs; [
    nmap
    whois
    dig
    netcat
    traceroute
    tcpdump
    sqlmap
    tor
    hashcat
    gobuster
    exploitdb
    zap
    aircrack-ng
  ];

  # zap needs it
  programs.firefox.enable = true;

  programs.wireshark = {
    enable = true;
    usbmon.enable= true;
    package = pkgs.wireshark;
  };
}
