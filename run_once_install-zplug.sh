#!/bin/sh

set -eu -o pipefail

if ! command -v zsh > /dev/null; then
    echo "zsh not installed"
    exit 1
fi

if [ ! -d "$HOME/.zplug" ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
