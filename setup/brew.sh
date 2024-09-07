#!/bin/sh bash

echo
echo "Installing Homebrew..."
echo

# Check if homebrew is installed
if test ! $(which brew); then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Uncomment this section if you are running a Mac with an Apple Silicon processor
# Be sure to change username here!
#echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/ceejsradx3/.zprofile
#eval "$(/opt/homebrew/bin/brew shellenv)"

  success "Homebrew successfully installed... continuing"
else
  success "Homebrew already installed, continuing..."
fi

echo
echo "Installing brew formulae and apps..."
echo

# update homebrew recipes
brew update && brew upgrade

# install formulae and apps from brewfile
brew bundle --global --file ./setup/brewfile

# clean up
brew update && brew upgrade &&  brew doctor && brew cleanup

# start install services and plugins
brew services start skhd