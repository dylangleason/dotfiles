# dotfiles

My dotfiles.

## Prerequisites

My dotfiles rely upon [chezmoi](https://github.com/twpayne/chezmoi), so [install it](https://github.com/twpayne/chezmoi/blob/master/docs/INSTALL.md#chezmoi-install-guide) before proceeding to the installation step.

## Installation

Use `chezmoi` to clone and initialize the dotfiles:

    chezmoi init https://github.com/dylangleason/dotfiles.git

Since `dot_emacs.d` is included via a submodule, this will need to be initialized as well:

    chezmoi cd && git submodule update --init --recursive

Finally, apply the changes:

    chezmoi apply
