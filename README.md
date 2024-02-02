# My dotfiles

This directory contains the dotfiles that I use on my machine.

## Requirements

Ensure that you have the following tools installed on your system.

### Git

```bash
pacman -S git
```

### Stow

```bash
pacman -S stow
```

### Installation

First, checkout the dotfiles repository in your $HOME directory.

```bash
git clone https://github.com/SamadKhafi/dot.git
cd dot
```

then use GNU stow to create symlinks.

```bash
stow .
```
