#!/bin/bash

# install xcode command line tools
xcode-select --install

# install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# install nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# install nix-darwin and apply the flake
nix run nix-darwin/master#darwin-rebuild -- switch .$(hostname -s)
