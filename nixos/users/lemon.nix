{ config, pkgs, ... }: let
in {
  environment.systemPackages = with pkgs; [
    pipewire
    ntfs3g
    home-manager
    grapejuice

    # GNUPG
    gnupg
    pinentry-curses

    grapejuice
  ];

  # bluetooth
  hardware.bluetooth.enable = true;

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
  
  services.gvfs.enable = true;

  # env vars
  environment.sessionVariables = rec {
    PROGDIR = "/mnt/Programming/CodingShit";
    CC = "clang";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Make some extra kernel modules available to NixOS
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ 
      v4l2loopback.out
    ];

  # Activate kernel modules (choose from built-ins and extra ones)
  boot.kernelModules = [
    # Virtual Camera
    "v4l2loopback"
    # Virtual Microphone, built-in
    "snd-aloop"
    # Uinput
    "uinput"
  ];

  # Set initial kernel module settings
  # https://github.com/umlaeute/v4l2loopback
  boot.extraModprobeConfig = ''
    options v4l2loopback card_label="Virtual Camera"
  '';
}
