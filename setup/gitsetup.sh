#!/bin/zsh

echo
echo "Let's configure git..."
echo

echo "Please enter your git username:"
read name
echo "Please enter your git email:"
read email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global color.ui true

echo
echo "✅ Git configuration complete!"
echo "User:  $(git config --global user.name)"
echo "Email: $(git config --global user.email)"