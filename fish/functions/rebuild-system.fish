function rebuild-system
  printf "\u001b[32m** NixOs **\n\u001b[0m";
  sudo nixos-rebuild switch --upgrade;
  printf "\u001b[32m** Home-Manager **\n\u001b[0m";
  home-manager switch --impure; 
end
