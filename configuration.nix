{ config, pkgs, version, ... }: let
in {
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
  ];
  
  # Remove old builds
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.autoUpgrade.enable = true;
  system.stateVersion = version;
}

