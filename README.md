# dotfiles

My dotfiles.

## Prerequisites

My dotfiles rely upon [chezmoi](https://github.com/twpayne/chezmoi), so [install it](https://github.com/twpayne/chezmoi/blob/master/docs/INSTALL.md#chezmoi-install-guide) before proceeding to the installation step.

## Installation

Use `chezmoi` to clone, initialize and apply the dotfiles all in one go:

    sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply dylangleason
