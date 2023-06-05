{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, hyprland, hyprpaper, ... }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.prometheus = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit hyprland hyprpaper; };
      modules = [ ./configuration.nix ./users/lemon.nix ];
    };
  };
}