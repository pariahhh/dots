# Get current path
set PAST $PWD
cd /etc/nixos

# Update Git
git add ./
git commit -m "[SCRIPT] Updated dot files! 🚀"
git push

# Go back
cd $PAST
