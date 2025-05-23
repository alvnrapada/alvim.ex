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

## Plugins

### Package Management
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager

### Core Functionality
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration
- [mason.nvim](https://github.com/williamboman/mason.nvim) - Package manager for LSP servers
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Bridge between mason and lspconfig
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting and code parsing
- [aerial.nvim](https://github.com/stevearc/aerial.nvim) - Code outline window
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - File icons

### Completion and Snippets
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - LSP completion source
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Buffer completion source
- [cmp-path](https://github.com/hrsh7th/cmp-path) - Path completion source
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) - Command line completion
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - Luasnip completion source

### File Navigation
- [fzf.vim](https://github.com/junegunn/fzf.vim) - Fuzzy finder
- [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder
- [nerdtree](https://github.com/scrooloose/nerdtree) - File explorer

### Git Integration
- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git wrapper

### Testing
- [vim-test](https://github.com/vim-test/vim-test) - Test runner

### Formatting and Linting
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatting engine
- [ale](https://github.com/dense-analysis/ale) - Asynchronous linting engine

### Language Support
- [vim-elixir](https://github.com/elixir-editors/vim-elixir) - Elixir support
- [phoenix.vim](https://github.com/c-brenn/phoenix.vim) - Phoenix framework support
- [vim-projectionist](https://github.com/tpope/vim-projectionist) - Project configuration

### Web Development
- [vim-jsx](https://github.com/mxw/vim-jsx) - React JSX support
- [vim-vue](https://github.com/storyn26383/vim-vue) - Vue.js support
- [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax) - CSS3 syntax support
- [vim-pug](https://github.com/digitaltoad/vim-pug) - Pug template support
- [vim-es6](https://github.com/isRuslan/vim-es6) - ES6 support
- [scss-syntax.vim](https://github.com/cakebaker/scss-syntax.vim) - SCSS syntax
- [vim-javascript](https://github.com/pangloss/vim-javascript) - JavaScript support
- [closetag.vim](https://github.com/vim-scripts/closetag.vim) - Auto close HTML tags
- [emmet-vim](https://github.com/mattn/emmet-vim) - HTML and CSS expansion

### Utility Plugins
- [vim-commentary](https://github.com/tpope/vim-commentary) - Comment stuff out
- [vim-unimpaired](https://github.com/tpope/vim-unimpaired) - Pairs of handy bracket mappings
- [vim-scriptease](https://github.com/tpope/vim-scriptease) - Vim script development
- [indentLine](https://github.com/Yggdroot/indentLine) - Display indentation levels
- [vim-grepper](https://github.com/mhinz/vim-grepper) - Helps you win at grep

### Color Schemes
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Clean, dark theme
- [catppuccin](https://github.com/catppuccin/nvim) - Soothing pastel theme
- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) - Theme inspired by the famous painting
- [sonokai](https://github.com/sainnhe/sonokai) - High contrast theme
- [onedark.vim](https://github.com/joshdick/onedark.vim) - Atom's iconic theme
- [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) - Dark theme
- [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) - VSCode-like theme

### Status Line
- [vim-airline](https://github.com/vim-airline/vim-airline) - Status/tabline
