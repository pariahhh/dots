{ config, pkgs, ... }:

{
  imports = [ ./users/lemon.nix ];

  # Allow unfree
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
