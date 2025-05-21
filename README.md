# Neovim Configuration

A modern Neovim setup optimized for Elixir, Phoenix, and web development.

## Prerequisites

Ensure you have the following installed on your Mac:
- XCode
- [HomeBrew](https://brew.sh)
- Git

## Installation

1. Install ripgrep (for better file searching):
```bash
brew install rg
```

2. Install Neovim:
```bash
brew install neovim
```

3. Install FZF (for fuzzy finding):
```bash
brew install fzf
```

4. Clone this repository:
```bash
mkdir -p ~/.config
git clone git@gitlab.com:alvnrapada/neovim-setup.git ~/.config/nvim
```

The configuration will automatically install all plugins on first launch.

## Usage

Launch Neovim using any of these commands:
```bash
nvim   # Preferred
vim    # Aliased to nvim
vi     # Aliased to nvim
```

## Features

- Fuzzy file finding with FZF (`<space>f`)
- File tree explorer with NERDTree (`<space>n`)
- Git integration with Fugitive
- Advanced code completion
- LSP support
- Modern themes with true color support

## Color Schemes

This setup includes several high-quality color schemes that you can switch between:

### Tokyo Night Theme
```vim
:TokyoNight            " Modern dark theme inspired by Tokyo at night
```

### Catppuccin Theme
```vim
:Catppuccin           " Switch to default Catppuccin (macchiato)

" Available flavors:
:colorscheme catppuccin-latte     " Light theme
:colorscheme catppuccin-frappe    " Medium-dark theme
:colorscheme catppuccin-macchiato " Darker theme
:colorscheme catppuccin-mocha     " Darkest theme (default)
```

### OneDark Theme
```vim
:OneDark           " Switch to default OneDark
```

### VSCode Theme
```vim
:VSCode          " Switch to default VSCode dark theme
```

For a complete list of available themes and their configurations, check the `lua/plugins/colorscheme.lua` file.

## Troubleshooting

### Plugin Issues
If you see errors related to plugins, try:
1. Cleaning the plugin directory:
```bash
rm -rf ~/.local/share/nvim/lazy/*
```

2. Restart Neovim and let it reinstall plugins automatically

### Theme Issues
If colors aren't displaying correctly:
1. Ensure your terminal supports true color
2. Add to your shell config (~/.zshrc or ~/.bashrc):
```bash
export TERM=xterm-256color
```

## Key Mappings

Leader key is set to `<space>`. Common mappings include:

### File Navigation
- `<space>f` - Fuzzy file finder (FZF)
- `<space>n` - Toggle NERDTree
- `<space>ag` - Search in files with Silver Searcher
- `<space>rg` - Search in files with Ripgrep

### Window Management
- `<space>mv` - Split window vertically
- `<space>ms` - Split window horizontally
- `<tab>` - Switch between windows

### Git Commands
- `<space>gs` - Git status
- `<space>gd` - Git diff view

For a complete list of mappings, check the `init.lua` file.
