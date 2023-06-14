{ lib, pkgs, secrets, ... }:
{
  home.packages = with pkgs; [
    # spotify
    spotify-tui
    spotifyd
  ];

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
