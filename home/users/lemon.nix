{ config, pkgs, ... }: let

in {
  # Environment Vars
  environment.variables = rec {
    "PROGDIR" = "/mnt/Programming/CodingShit";
  };
}
