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
    protonup-ng
    obs-studio
    prismlauncher
    grapejuice
    lutris

    # Pipewire
    pavucontrol
    #helvum
    noisetorch

    # Internet
    nmap

    # GPU
    python310Packages.gpustat

    # Terminal
    kitty
    neofetch
    bat
    exa
    openssl

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
    wineWowPackages.stagingFull
    bottles
    winetricks

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
    # Code source to image
    silicon

    # js
    yarn
    nodejs

    # go
    go

    # editor
    helix
    hexyl

    # Haskell
    haskell.compiler.ghc942
    stack
    cabal-install
    ihp-new

    # Borwsers
    firefox
    ungoogled-chromium

    # Java
    jdk17_headless

    # Fonts
    nerdfonts

    # Other
    spotify
    obsidian
    keepassxc
    libreoffice
    xautoclick
  ];
}
