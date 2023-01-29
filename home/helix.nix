{ inputs, pkgs, ... }:

@ args: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default;

    settings = {
      theme = "ayu-mirage"

      editor = {
        true-color = true;
        color-modes = true;
        cursorline = true;
      
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        
        rainbow-brackets = true;
      };
    };
  }
}
