{ config, pkgs, use-wayland, ... }: let

in {
  imports = [
    ./settings.nix
    ./x11.nix
  ];

  environment.systemPackages = with pkgs; [
    pipewire
    ntfs3g

    # GNUPG
    gnupg
    pinentry-curses
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

  # Flatpak
  services.flatpak.enable = true;

  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = { # this fixes the "glXChooseVisual failed" bug, context: https://github.com/NixOS/nixpkgs/issues/47932
    enable = true;
    driSupport32Bit = true;
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
  
  services.gvfs.enable = true;

  services.ratbagd.enable = true;
}
