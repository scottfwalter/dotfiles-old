#!/usr/bin/env zsh

ibrew="/usr/local/bin/brew"
if test ! $(which brew); then
  if [ "`uname -m`"  = 'arm64' ]; then
    # Intel Version
    arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    /usr/local/bin/brew update

    # Arm64 Version
    sudo mkdir -p /opt/homebrew
    sudo chown -R $(whoami):staff /opt/homebrew
    cd /opt
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    /opt/homebrew/bin/brew update
  fi
else
  echo "Brew already installed"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
    if [[ -f "/usr/local/bin/brew" ]]; then
      ibrew="arch -x86_64 /usr/local/bin/brew"
    fi
fi

# Make sure we’re using the latest Homebrew.
if [ "`uname -m`"  = 'arm64' ]; then
    echo "Update Arm64 Brew"
    brew update

    echo "Update Intel Brew"
    eval "$ibrew update"
else
    brew update
fi

# brew tap Homebrew/cask-drivers

BREW_PREFIX=$(brew --repository)

###########################################
# Core Tools
###########################################

# brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Tmux
brew install tmux

# telnet
brew install telnet

# Tag
eval "$ibrew install tag"

# Ripgrep
eval "$ibrew install ripgrep"

# MAS - Install App Store
eval "$ibrew install mas"

###########################################
#System Info
###########################################

# archey - system information
brew install archey

###########################################
#Dev Tools
###########################################
# JO https://github.com/jpmens/jo
brew install jo

# JQ https://stedolan.github.io/jq/
brew install jq

# pup https://github.com/ericchiang/pup
eval "$ibrew install pup"

 brew install httpie

 brew install unrar

###########################################
#Media
###########################################

# ffmpeg
eval "$ibrew install ffmpeg"

# youtube-dl
brew install youtube-dl

###########################################
#Finish Up
###########################################
Echo "Make sure to user the Inconsolta Awesome Font!"