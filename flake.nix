{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    # Home-manager packager
    home-manager.url = "github:nix-community/home-manager";
    # helix bs (the workaround is insane)
    dream2nix.url = "github:nix-community/dream2nix";
    nci = {
      url = "github:yusdacra/nix-cargo-integration";
      inputs.dream2nix.follows = "dream2nix";
    };
    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nci.follows = "nci";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib.url = "github:hyprwm/contrib";
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
  };

  outputs = {
    self, nixpkgs, hyprland, xdg-desktop-portal-hyprland, home-manager, helix-master, hypr-contrib, flatpaks, ... 
  }: let
    system = "x86_64-linux";
    stateVersion = "23.05";
    
    host = "prometheus";
    default-user = "lemon";
    secrets = import ./secrets.nix;

    use-wayland = true;
  in {
    homeConfigurations = import ./home/home-configuration.nix { 
      inherit nixpkgs system home-manager default-user helix-master secrets stateVersion hypr-contrib flatpaks; 
    };

    nixosConfigurations = {
      "prometheus" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hyprland xdg-desktop-portal-hyprland use-wayland stateVersion; };
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