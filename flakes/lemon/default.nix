{}: let
  home-manager = import ./home-manager.nix;
  system = import ./system.nix;
in {
  inherit home-manager system;
}
