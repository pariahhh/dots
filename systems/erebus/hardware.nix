{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    efi = {
      # canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      configurationLimit = 5;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          search --fs-uuid --no-floppy --set=root 8C07-315B
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    }; 
  };

  # Make some extra kernel modules available to NixOS
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ 
      v4l2loopback.out
    ];

  boot.supportedFilesystems = [ "ntfs" ];
}
