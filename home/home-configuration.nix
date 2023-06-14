{ system, nixpkgs, home-manager, default-user, helix-master, secrets, stateVersion, hypr-contrib, flatpaks, ... }:

let
  username = default-user;
  homeDirectory = "/home/${default-user}";
  configHome = "${homeDirectory}/.nix";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
  };

  home-nix = (../home + "/${username}/home.nix");
in
{
  "${username}" = home-manager.lib.homeManagerConfiguration {
    pkgs = pkgs;
    extraSpecialArgs = { inherit helix-master username homeDirectory secrets stateVersion hypr-contrib; }; 
    modules = [
      flatpaks.homeManagerModules.default
      home-nix
    ];
  };
}