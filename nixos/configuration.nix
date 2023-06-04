{ config, pkgs, ... }: let
  use-wayland = import ./use-wayland.nix;
  backend = 
    if use-wayland == true then 
      ./wayland.nix
    else
      ./x11.nix;
in {
  imports = [
    ./hardware-configuration.nix
    ./settings.nix
    <home-manager/nixos>
    backend
  ];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
  
  system.copySystemConfiguration = true;

  # Remove old builds
  nix.gc = {
    automatic = true;
    dates = "3d";
    options = "--delete-older-than 3d";
  };

  # zsh default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  system.autoUpgrade.enable = true;
  system.stateVersion = "22.11";
}

