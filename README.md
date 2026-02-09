# My dotfiles

This repository contains my personal dotfiles

## Requirements

The following packages are required for this to work

### Git

Ubuntu: ```sudo apt install git```

MacOS: ```brew install git```

### GNU Stow

Ubuntu: ```sudo apt install stow```

MacOS: ```brew install stow```

## Installation

First, checkout the repo in your `$HOME` directory using git

```
cd ~
git clone git@github.com:marius-brauterfallet/dotfiles.git
cd dotfiles
```

the use GNU Stow to create symlinks for the dotfiles you want to use, for instance

```
cd ~/dotfiles
stow zshrc
```
