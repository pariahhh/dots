{ config, pkgs, inputs, ... }: let
  GIT_SECRET = import /etc/secrets/git-key.nix;
in {
  # Path
  home.username = "lemon";
  home.homeDirectory = "/home/lemon";

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXPKGS_ALLOW_BROKEN = "1";
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

  # zsh
  programs.zsh = {
    enable = true;
    shellAliases = {
      rebuild-system = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --impure'';
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "darkblood";
    };
  };

  home.packages = with pkgs; [
    inputs.unreale4.packages.x86_64-linux.default
    # Discord
    discord-canary

    # Gaming
    steam
    sc-controller
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
    zsh
    oh-my-zsh
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

    # Unreal engine {broken}
    # ue4

    # Other
    spotify
    obsidian
    keepassxc
    libreoffice
    xautoclick
  ];
}
