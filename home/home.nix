{ config, pkgs, ... }: let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  GIT_SECRET = import ~/.config/secret/git-key.nix;
in {
  imports = [
  ];

  # Allow Unfree
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "LemonjamesD";
    userEmail = "lemon@lemonjamesd.com";
    signing = { 
      signByDefault = true;
      key = GIT_SECRET;
    };
  };

  # Hyprland
  # wayland.windowManager.hyprland.enable = true;

  home.packages = with pkgs; [ 
    # communinication
    discord 
    discord-canary
    
    # gaming
    steam
    obs-studio

    # pipewire stuff
    pavucontrol
    helvum
    noisetorch

    # terminal
    fish
    kitty
    alacritty
    neofetch
    htop
    tigervnc
    nmap
    git
    unzip
    bat
    mlocate
    gitui
    pciutils
    hwinfo

    # screenshots
    grim
    slurp
    feh

    # js
    yarn
    nodejs

    # go
    go

    helix

    # File explorer
    gnome.gnome-disk-utility
    dolphin

    # Haskell
    haskell.compiler.ghc942
    stack
    cabal-install
        
    # useful
    keepassxc
    ungoogled-chromium
    firefox
    gimp

    # other
    spotify
    obsidian
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lemon";
  home.homeDirectory = "/home/lemon";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
