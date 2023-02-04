{ config, pkgs, ... }:

{
  # env vars
  environment.variables = rec {
    "PROGDIR" = "/mnt/Programming/CodingShit";
  };
}
