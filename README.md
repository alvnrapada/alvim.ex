# My Neovim Setup for Elixir Development

This is my latest Neovim setup for Elixir Development.

![Frame 5](https://github.com/user-attachments/assets/69a4a4cf-3bae-4824-b236-f6f30b6551a7)


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

4. Make a backup of your current Neovim files:
```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

5. Clone this repository:
```bash
mkdir -p ~/.config
git clone git@gitlab.com:alvnrapada/neovim-setup.git ~/.config/nvim
```

6. Remove the .git folder (so you can add it to your own repo later):
```bash
rm -rf ~/.config/nvim/.git
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

```vim
:VSCode (Default)
:TokyoNight
:OneDark
:Kanagawa
:Sonokai
:Dracula
:Catppuccin 

" Available flavors for catppuccin:
:colorscheme catppuccin-latte     " Light theme
:colorscheme catppuccin-frappe    " Medium-dark theme
:colorscheme catppuccin-macchiato " Darker theme
:colorscheme catppuccin-mocha     " Darkest theme (default)

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

### Test Commands (vim-test)
- `<space>tn` - Run the test nearest to the cursor
- `<space>tl` - Run the last test
- `<space>tg` - Visit the test file
- `<space>tt` - Run the current test file
- `<space>ta` - Run all tests in the suite

For a complete list of mappings, check the `init.lua` file.
