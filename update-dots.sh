# Get current path
set PAST $PWD
cd /etc/nixos

# Update Git Main Branch
git checkout main
git pull
git add .
git commit -m "[SCRIPT] Updated dot files! 🚀"
git push

# Copy README to eww
cd ~/.config/eww
git pull
cp /etc/nixos/README.md ./
git add README.md
git commit -m "[SCRIPT] Updated \`eww\` README! 🚀"
git push



# Go back
cd $PAST
