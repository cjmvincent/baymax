#!/bin/zsh

set -e

# set script's directory so sources are reliable
SCRIPT_DIR="${0:A:h}"

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

if [[ "$(uname -m)" != "arm64" ]]; then
  echo "Warning: this script was written with Apple silicon in mind."
fi

# ask for the administrator password upfront.
echo Please enter root password
sudo -v

echo
echo "Setting up your Mac..."
echo

# check for command line tools, but also to make sure the git dependency is met
echo
echo "Checking for Command Line Tools..."
echo
if ! xcode-select -p &>/dev/null; then
  echo "Command Line Tools not found. Installing..."
  xcode-select --install
  echo
  echo "Please complete the Command Line Tools installation in the popup window."
  echo "Press any key once installation is complete..."
  read -k1 -s
else
  echo "Command Line Tools already installed."
fi


# install Rosetta
if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
  echo "Installing Rosetta 2 (optional but recommended for some apps)…"
  softwareupdate --install-rosetta --agree-to-license || true
fi

# check for and install homebrew as well as any dependencies and desired packages
echo "Installing Homebrew packages..."
source "${SCRIPT_DIR}/setup/brew.sh"

# configure terminal by installing ohmyzsh and powerlevel10k theme
echo "Setting up your terminal..."
source "${SCRIPT_DIR}/setup/terminal.sh"

# load macOS preferences
echo "Importing your MacOS preferences..."
source "${SCRIPT_DIR}/setup/macos.sh"

# replace dock apps
echo "Setting your desired dock..."
source "${SCRIPT_DIR}/setup/dock.sh"

# restore mackup backup
# echo
# echo "Restoring your mackup backup..."
# echo
# cp "${SCRIPT_DIR}/setup/mackup.cfg $HOME/.mackup.cfg"
# mackup restore

# install dotfiles with dotbot
echo
echo "Restoring dotfiles with dotbot..."
echo
DOTDIR="${HOME}/.dotfiles"
if [[ -d "${DOTDIR}/.git" ]]; then
  git -C "${DOTDIR}" pull --rebase
else
  git clone https://github.com/cjmvincent/dotfiles.git "${DOTDIR}"
fi
cd "${DOTDIR}"
./install


echo "______ _____ _   _  _____ "
echo "|  _  \  _  | \ | ||  ___|"
echo "| | | | | | |  \| || |__  "
echo "| | | | | | | .   ||  __| "
echo "| |/ /\ \_/ / |\  || |___ "
echo "|___/  \___/\_| \_/\____/ "

echo
read -r "REPLY?Do you want to reboot the system? [y/N] "
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  sudo reboot
fi