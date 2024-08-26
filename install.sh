#!/bin/sh

# Set the package manager to use
PKG_MANAGER="dnf"

# Check if the package manager is available
if ! command -v "$PKG_MANAGER" &> /dev/null; then
  echo "Error: $PKG_MANAGER is not available on this system."
  exit 1
fi

# Update the package list
echo "Updating package list..."
if ! sudo "$PKG_MANAGER" update -y; then
  echo "Error: Failed to update package list."
  exit 1
fi

# Install Development Tools
echo "Installing Development Tools..."
if ! sudo "$PKG_MANAGER" groupinstall "Development Tools" -y; then
  echo "Error: Failed to install Development Tools."
  exit 1
fi

# Install additional packages
echo "Installing additional packages..."
PACKAGES="neovim nodejs npm ripgrep git zsh"
for pkg in $PACKAGES; do
  if ! sudo "$PKG_MANAGER" install "$pkg" -y; then
    echo "Error: Failed to install $pkg."
    exit 1
  fi
done

# Clone and install fzf
echo "Installing fzf..."
if ! git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; then
  echo "Error: Failed to clone fzf repository."
  exit 1
fi
if ! ~/.fzf/install; then
  echo "Error: Failed to install fzf."
  exit 1
fi

# Add 1Password repository and install 1password-cli
echo "Installing 1Password CLI..."
if ! sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc; then
  echo "Error: Failed to import 1Password GPG key."
  exit 1
fi
if ! sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'; then
  echo "Error: Failed to add 1Password repository."
  exit 1
fi
if ! sudo "$PKG_MANAGER" check-update -y 1password-cli && sudo "$PKG_MANAGER" install 1password-cli; then
  echo "Error: Failed to install 1password-cli."
  exit 1
fi

# Print success message
echo "Process complete!"
