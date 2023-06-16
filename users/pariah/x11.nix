{ config, pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    sddm
    plasma-desktop
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
}
