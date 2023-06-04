{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    cargo2nix.url = "github:cargo2nix/cargo2nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-master.url = "github:SoraTenshi/helix/new-daily-driver";
  };

  outputs = {self, nixpkgs, home-manager, helix-master, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      "lemon" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit helix-master; };
        modules = [ ./home.nix ];
      };
    };
  };
}
