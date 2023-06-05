# Get current path
set PAST $PWD
cd ~/.dots

# Eww
rm -r ~/.dots/eww
cp -r ~/.config/eww ~/.dots

# Hyprland
rm -r ~/.dots/hypr
cp -r ~/.config/hypr/ ~/.dots

# Helix
# rm -r ~/.dots/helix
# cp -r ~/.config/helix ~/.dots

# Nixos
rm -r ~/.dots/nixos
cp -r /etc/nixos/ ~/.dots

# Home-manager
cp -r ~/.config/nixpkgs/ ~/.dots
rm -r ~/.dots/home
mv -f ~/.dots/nixpkgs ~/.dots/home

# Update Git
git add ./
git commit -m "[SCRIPT] Updated dot files! 🚀"
git push

# Go back
cd $PAST
