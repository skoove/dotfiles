{ pkgs , ... }:
{
  # hi people looking at my config, i am not a script kiddie, i am actually
  # learning (responsibly! i have a homelab [1])
  #
  # [1] https://github.com/skoove/server-configurations
  environment.systemPackages = with pkgs; [
    nmap
    whois
    dig
    netcat
    traceroute
    tcpdump
    wireshark
    sqlmap
    tor
    hashcat
    gobuster
    exploitdb
  ];
}
