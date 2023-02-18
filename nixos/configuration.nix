# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: let
  use-wayland = import ./use-wayland.nix;
  backend = 
    if use-wayland == true then 
      ./wayland.nix
    else
      ./x11.nix;
in {
  imports = [
    # User specific settings
    ./users/lemon.nix
   
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

  system.autoUpgrade.enable = true;
  system.stateVersion = "22.11";
}

