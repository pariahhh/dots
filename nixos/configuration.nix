# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: let
  use-wayland = false;
  backend = 
    if use-wayland == true then 
      ./wayland.nix
    else
      ./x11.nix;
in {
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
    backend
  ];

  # Environment vars
  environment.variables = rec {
    "PROGDIR" = "/run/Programming/CodingShit";
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    sddm
    pipewire
    ntfs3g
    home-manager
    fish
    plasma-desktop
    grapejuice

    # GNUPG
    gnupg
    pinentry-curses
    
    # thunar stuff
    xfce.thunar
    xfce.thunar-volman
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
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "prometheus"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak-programmer";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lemon = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "video"
      "audio"
    ]; # Enable ‘sudo’ for the user.
  };

  # Thunar
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
  ];

  services.gvfs.enable = true;

  # Use fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages (free as in freedom)
  # this shit ain't never working fr
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Allow experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

