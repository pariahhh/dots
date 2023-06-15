{}: let
  inputs = {
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
in {

  inherit inputs;
}
