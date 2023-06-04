{ config, pkgs, ... }: let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
  GIT_SECRET = import /etc/secrets/git-key.nix;
in {

  imports = [
    "/home/lemon/.config/nixpkgs/helix.nix"
  ];

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
      rebuild-system = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch --impure && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --impure'';
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "darkblood";
    };
  };

  home.packages = with pkgs; [
    # Haguichi
    logmein-hamachi
    haguichi
    # Discord
    # discord-canary
    element-desktop
    unstable.webcord-vencord

    # Gaming
    steam
    protontricks
    sc-controller
    protonup-ng
    unstable.obs-studio
    prismlauncher
    lutris

    # Pipewire
    pavucontrol
    # helvum
    noisetorch

    # Internet
    nmap

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
    gnumake
    gcc

    # git
    git
    gitoxide
    gitui

    # llvm
    llvm
    lld

    # system tools
    hwinfo
    pciutils

    # wine
    wineWowPackages.stable
    bottles
    winetricks

    # Rust
    rustup
    rust-analyzer
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

    # Python
    python310
    unstable.python310Packages.pip
    python310Packages.gpustat
    python310Packages.tkinter
    python310Packages.python-uinput
    tk

    # go
    go

    # editor
    hexyl

    # Haskell
    haskell.compiler.ghc942
    stack
    cabal-install
    haskellPackages.hindent
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
    SDL2
    sqlitebrowser
    youtube-dl
    protonvpn-gui
    nvtop
    libqalculate
    htop
    cascadia-code
    blender
    sqlite

    # Controller
    qjoypad
    jstest-gtk

    # Bluetooth
    bluez
    bluez-tools
    blueman
  ];
}
