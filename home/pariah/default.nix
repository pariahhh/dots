{ config, pkgs, username, homeDirectory, stateVersion, secrets, ... }: let
  baseconfig = { allowUnfree = true; };
in {
  imports = [
    ../shared/gaming.nix
  ];

  home = {
    inherit username homeDirectory stateVersion;
  };

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXPKGS_ALLOW_BROKEN = "1";
  };

  services.kdeconnect.enable = true;

  # zsh
  programs.zsh = {
    enable = true;
    shellAliases = {
      rebuild-system = ''echo -e "\x1b[0;32mNixOs\x1b[0m" && sudo nixos-rebuild switch --flake /etc/nixos --impure && echo -e "\x1b[0;32mHome-manager\x1b[0m" && home-manager switch --flake /etc/nixos --impure'';
      update-dots = ''export GOBACK="$(pwd)" && cd /etc/nixos && git pull && ./update-dots.sh && cd $GOBACK'';
      pull-upstream = ''export GOBACK="$(pwd)" && cd /etc/nixos && git pull && cd $GOBACK'';
      edit-packages = ''nano /etc/nixos/home/pariah/default.nix'';
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "darkblood";
    };
  };

# Git
  programs.git = {
    enable = true;
    userName = "pariahhh";
    userEmail = "shawnwarrick04@gmail.com";
    signing = {
      signByDefault = true;
      key = secrets.git-key;
    };
  };

  home.packages = with pkgs; [
    discord-canary

    wineWowPackages.stagingFull
    piper

    libsForQt5.clip

    # REQUIRED FONTS (DO NOT DELETE)
    noto-fonts
    noto-fonts-emoji

    betterdiscordctl
    kdeconnect
  ];

  services.flatpak = {
    remotes = {
      "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:com.discordapp.Discord"
    ];
  };
}
