{ lib, pkgs, secrets, ... }:
{
  home.packages = with pkgs [
    # spotify
    spotify-tui
    spotifyd
  ];

  networking.firewall.allowedTCPPorts = [ 57621 ];

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = secrets.spotify-username;
        password = secrets.spotify-password;
      };
    };
  };
}
