#!/bin/sh bash


# needed vars
processor_brand="$(/usr/sbin/sysctl -n machdep.cpu.brand_string)"


clear
echo
echo " _           _        _ _       _     "
echo "(_)         | |      | | |     | |    "
echo " _ _ __  ___| |_ __ _| | |  ___| |__  "
echo "| | |_ \/ __| __/ _  | | | / __| |_ \ "
echo "| | | | \__ \ || (_| | | |_\__ \ | | |"
echo "|_|_| |_|___/\__\__,_|_|_(_)___/_| |_|"
echo
echo
echo Please enter root password

# ask for the administrator password upfront.
sudo -v

echo
echo "Setting up your Mac..."
echo

# check for and install homebrew as well as any dependencies and desired packages
source ./setup/brew.sh

# configure terminal by installing ohmyzsh and powerlevel10k theme
source ./setup/terminal.sh

# load macOS preferences
source ./setup/macos

# replace dock apps
source ./setup/dock.sh

# restore mackup backup
# echo
# echo "Restoring your mackup backup..."
# echo
# cp ./setup/mackup.cfg $HOME/.mackup.cfg
# mackup restore

# install dotfiles with dotbot
echo
echo "Restoring dotfiles with dotbot..."
echo
git clone https://github.com/cjmvincent/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
./install


echo "______ _____ _   _  _____ "
echo "|  _  \  _  | \ | ||  ___|"
echo "| | | | | | |  \| || |__  "
echo "| | | | | | | .   ||  __| "
echo "| |/ /\ \_/ / |\  || |___ "
echo "|___/  \___/\_| \_/\____/ "

echo
echo -n "Do you want to reboot the system? [y/N]"
read REPLY
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo reboot
else
  exit
fi