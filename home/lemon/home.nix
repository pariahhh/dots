{ config, pkgs, username, homeDirectory, inputs, ... }:

{
  imports = [ ./lemon.nix { inherit inputs; } ];

  # Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.stateVersion = inputs.version;
  home = {
    inherit username homeDirectory;
  };
}
