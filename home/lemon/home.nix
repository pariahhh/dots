{ config, pkgs, username, homeDirectory, stateVersion, hypr-contrib, ... }:

{
  imports = [ ./lemon.nix ];

  # Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  home = {
    inherit username homeDirectory stateVersion;
  };
}
