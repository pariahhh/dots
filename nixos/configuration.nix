# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
    ./wayland.nix
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


  #services.xserver = {
  #  enable = true;

  #  # Keyboard layout
  #  layout = "us";
  #  xkbVariant = "dvp";
    
  #  displayManager = {
  #    lightdm.enable = true;
  #  };

  #  desktopManager = {
  #     # plasma5.enable = true;
  #  };
  #};

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
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.autoUpgrade.enable = true;
  system.stateVersion = "22.11"; # Did you read the comment?

}

