{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    # Home-manager packager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-master.url = "github:SoraTenshi/helix/new-daily-driver";
    hypr-contrib.url = "github:hyprwm/contrib";
  };

  outputs = {
    self, nixpkgs, hyprland, xdg-desktop-portal-hyprland, home-manager, helix-master, hypr-contrib,... 
  }: let
    system = "x86_64-linux";
    version = "23.05";
    
    host = "prometheus";
    default-user = "lemon";
    secrets = import ./secrets.nix;

    use-wayland = true;
  in {
    homeConfigurations = import ./home/home-configuration.nix { 
      inherit nixpkgs system home-manager default-user helix-master secrets hypr-contrib version; 
    };

    nixosConfigurations = {
      "prometheus" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hyprland xdg-desktop-portal-hyprland use-wayland version; };
        modules = [ 
          # System
          (./configuration.nix)
          (./systems + "/${host}/hardware.nix")
          # User
          (./users + "/${default-user}/${default-user}.nix")
        ];
      };
    };
  };
}