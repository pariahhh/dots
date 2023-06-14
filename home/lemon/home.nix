{ config, pkgs, username, homeDirectory, stateVersion, hypr-contrib, ... }:

{
  imports = [ ./lemon.nix { inherit hypr-contrib; } ];

  # Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  home = {
    inherit username homeDirectory stateVersion;
  };
}
