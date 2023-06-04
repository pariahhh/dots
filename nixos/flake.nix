{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs}@inputs: let
  in {
    nixosConfigurations.prometheus = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ./users/lemon.nix ];
    };
  };
}