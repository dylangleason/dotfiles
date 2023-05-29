# dotfiles

My dotfiles.

## Prerequisites

My dotfiles rely upon [chezmoi](https://www.chezmoi.io/), so [install it](https://www.chezmoi.io/install/) before proceeding to the installation step.

## Installation

Use `chezmoi` to clone, initialize and apply the dotfiles all in one go:

    sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply "${GITHUB_USERNAME:-dylangleason}"
