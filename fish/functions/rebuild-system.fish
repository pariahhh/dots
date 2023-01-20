function rebuild-system --wraps='home-manager switch && sudo nixos-rebuild switch' --wraps='home-manager switch && sudo nixos-rebuild switch --upgrade' --wraps='sudo nixos-rebuild switch --upgrade && home-manager switch' --description 'alias rebuild-system=sudo nixos-rebuild switch --upgrade && home-manager switch'
  sudo nixos-rebuild switch --upgrade && home-manager switch $argv; 
end
