cd ~/.dots

# Eww
cp -r ~/.config/eww ~/.dots
git rm --cached eww/.dotfiles-hyprland

# Hyprland
cp -r ~/.config/hypr/ ~/.dots

# Helix
cp -r ~/.config/helix ~/.dots

# Nixos
cp -r /etc/nixos/ ~/.dots

# Home-manager
cp -r ~/.config/nixpkgs/ ~/.dots
rm -r ~/.dots/home
mv -f ~/.dots/nixpkgs ~/.dots/home

# Update Git
git add ./
git commit -m "Updated dot files"
git push
