{ config, pkgs, ... }: let
  GIT_SECRET = import /etc/secrets/git-key.nix;
in {
  # Path
  home.username = "lemon";
  home.homeDirectory = "/home/lemon";

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

  home.packages = with pkgs; [
    # Discord
    discord-canary

    # Gaming
    steam
    obs-studio
    prismlauncher
    grapejuice

    # Pipewire
    pavucontrol
    noisetorch

    # Internet
    nmap

    # GPU
    python310Packages.gpustat

    # Terminal
    kitty
    neofetch
    bat

    # vnc
    tigervnc

    # archives
    unzip

    # C
    cmake

    # git
    git
    gitui

    # llvm
    llvm
    lld

    # system tools
    hwinfo
    pciutils

    # wine
    wineWowPackages.waylandFull

    # Rust
    rustup
    pkg-config

    # Screenshots
    grim
    slurp

    # Imaging tools
    feh
    mpv
    gimp

    # js
    yarn
    nodejs

    # go
    go

    # editor
    helix

    # Haskell
    haskell.compiler.ghc942
    stack
    cabal-install

    # Borwsers
    firefox
    ungoogled-chromium

    # Java
    jdk17_headless

    # Other
    spotify
    obsidian
  ];
}
