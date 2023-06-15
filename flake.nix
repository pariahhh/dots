let
  try-import = import ./helpers/try-import.nix;

  system = "x86_64-linux";
  stateVersion = "23.05";

  # Get the host and user
  host = builtins.getEnv "HOST";
  user = builtins.getEnv "USERNAME";

  secrets = import ./secrets.nix;

  use-wayland = false;
in {
  inputs = {
    inherit (import (./flakes + "/${user}"));
  };

  outputs = {
    self, nixpkgs, hyprland, xdg-desktop-portal-hyprland, home-manager, helix-master, hypr-contrib, flatpaks, ... 
  }@inputs: {
    homeConfigurations = import ./home/home-configuration.nix { 
      inherit nixpkgs system stateVersion host user secrets use-wayland inputs; 
    };

    nixosConfigurations = {
      "prometheus" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit nixpkgs system stateVersion host user secrets use-wayland inputs; };
        modules = [ 
          # System
          (./configuration.nix)
          (./systems + "/${host}/hardware.nix")
          # User
          (./users + "/${user}/${user}.nix")
        ];
      };
    };
  };
}