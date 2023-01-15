# Get current path
set PAST $PWD
cd ~/.dots

# Eww
cp -r ~/.config/eww ~/.dots

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

# Go back
cd $PAST
