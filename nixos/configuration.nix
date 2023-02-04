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
  imports =
  [ # Include the results of the hardware scan.
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
    pipewire
    ntfs3g
    home-manager

    # GNUPG
    gnupg
    pinentry-curses 
  ];

  # GNUPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = { # this fixes the "glXChooseVisual failed" bug, context: https://github.com/NixOS/nixpkgs/issues/47932
    enable = true;
    driSupport32Bit = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Thunar
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];
  
  services.gvfs.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
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

