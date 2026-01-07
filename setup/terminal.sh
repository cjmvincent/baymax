#!/bin/zsh

echo
echo "Configuring your terminal..."
echo

# install oh-my-zsh
if [[ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]]; then
  echo "Installing Oh My Zsh (non-interactive)…"
  export RUNZSH=no CHSH=no KEEP_ZSHRC=yes
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
  echo "Oh My Zsh already installed. Updating…"
  # Update without sourcing user rc files
  git -C "${ZSH:-$HOME/.oh-my-zsh}" pull --rebase --autostash || true
fi

# install Powerlevel10k
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k

# Set ZSH_CUSTOM to the standard location
ZSH_CUSTOM="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}"

# install a couple of zsh plugins
ZSH_HIGHLIGHT_DIR="${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
if [[ ! -d "${ZSH_HIGHLIGHT_DIR}/.git" ]]; then
  echo "Installing zsh-syntax-highlighting…"
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_HIGHLIGHT_DIR}"
else
  echo "Updating zsh-syntax-highlighting…"
  git -C "${ZSH_HIGHLIGHT_DIR}" pull --rebase --autostash || true
fi

ZSH_AUTOSUGGEST_DIR="${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
if [[ ! -d "${ZSH_AUTOSUGGEST_DIR}/.git" ]]; then
  echo "Installing zsh-autosuggestions…"
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_AUTOSUGGEST_DIR}"
else
  echo "Updating zsh-autosuggestions…"
  git -C "${ZSH_AUTOSUGGEST_DIR}" pull --rebase --autostash || true
fi

echo
echo "Terminal setup complete. Plugins and theme are installed/updated."
echo "Your dotfiles (via dotbot) should enable them in .zshrc."