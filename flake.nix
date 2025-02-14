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
  }@inputs: let
    try-import = import ./helpers/try-import.nix;

    system = "x86_64-linux";
    stateVersion = "23.05";

    secrets = import "/etc/nixos/secrets.nix";

    # Get the host and user
    host = secrets.host;
    user = secrets.user;

    use-wayland = false;
    
    mkNixOS = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit nixpkgs system stateVersion host user secrets use-wayland inputs; };
      modules = [ 
        # System
        (./configuration.nix)
        (./systems + "/${host}/hardware.nix")
        # User
        (./users + "/${user}/default.nix")
      ];
    };
  in {
    homeConfigurations = import ./home/home-configuration.nix { 
      inherit home-manager nixpkgs system stateVersion host user secrets use-wayland inputs; 
    };

    nixosConfigurations = {
      "${host}" = mkNixOS;
      "nixos" = mkNixOS;
    };
  };
}