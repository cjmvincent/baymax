#!/bin/zsh

ARCH="$(uname -m)"

echo
echo "Installing Homebrew..."
echo

# Check if homebrew is installed
if ! command -v brew &>/dev/null; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ "$ARCH" == "arm64" ]]; then
    echo "Apple Processor is present..."
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  echo "Homebrew successfully installed... continuing"
else
  echo "Homebrew already installed, continuing..."
fi

echo
echo "Installing brew formulae and apps..."
echo

# update homebrew recipes
brew update && brew upgrade

# install formulae and apps from brewfile
BREWFILE="${SCRIPT_DIR}/setup/brewfile"
if [[ -f "$BREWFILE" ]]; then
  echo "Installing formulae and casks from $BREWFILE…"
  # --no-lock avoids writing Brewfile.lock.json in your repo
  brew bundle --file="$BREWFILE" --no-lock || {
    echo "⚠️ brew bundle reported errors. Continuing to post-steps…"
  }
else
  echo "⚠️ Brewfile not found at $BREWFILE — skipping bundle."
fi

# clean up
brew update && brew upgrade &&  brew doctor && brew cleanup

# start install services and plugins
skhd --start-service
yabai --start-service
brew services start sketchybar
brew services start borders

echo
echo "✅ Homebrew setup complete."