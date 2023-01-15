# Hyprland
cp -r ~/.config/hypr/hyprland.conf ./

# Helix
cp -r ~/.config/helix ./

# Nixos
cp -r /etc/nixos/ ./

# Home-manager
cp -r ~/.config/nixpkgs/ ./
rm -r ./home
mv -f ./nixpkgs ./home
