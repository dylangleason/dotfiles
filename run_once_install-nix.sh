#!/usr/bin/env bash

set -eu -o pipefail

if [[ ! -d /nix/store ]]; then
    curl -L https://nixos.org/nix/install | sh
fi

if [[ ! -e ~/.nix-profile/bin/home-manager ]]; then
    . ~/.nix-profile/etc/profile.d/nix.sh;
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
fi
