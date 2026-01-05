# jj-zsh-theme

A minimal Oh-My-Zsh theme with [jj (jujutsu)](https://github.com/martinvonz/jj) support and git fallback.

## Features

- Line 1: path + VCS info
- Line 2: prompt character
- jj support: change_id, description, +/- stats
- Git fallback: branch, +/- stats
- Shows git user name

## Preview

```
~/code/project jj:kzomtlut feat: add new feature +10 -5 username
❯
```

## Installation

### Oh-My-Zsh

```bash
# Clone to custom themes directory
git clone https://github.com/panjx/jj-zsh-theme.git $ZSH_CUSTOM/themes/jj-zsh-theme

# Symlink the theme
ln -s $ZSH_CUSTOM/themes/jj-zsh-theme/jj.zsh-theme $ZSH_CUSTOM/themes/jj.zsh-theme

# Set theme in ~/.zshrc
ZSH_THEME="jj"
```

### Manual

Copy `jj.zsh-theme` to `~/.oh-my-zsh/custom/themes/` and set `ZSH_THEME="jj"` in your `~/.zshrc`.

## Requirements

- [jj](https://github.com/martinvonz/jj) (optional, falls back to git)
- git

## License

MIT
