# Getting Started with Elixir Development on macOS

This guide will walk you through setting up a complete Elixir development environment on your Mac.

## Prerequisites

Before we begin, make sure you have:
- A Mac running macOS
- Terminal.app or iTerm2
- Basic familiarity with command line operations

## Step 1: Install Homebrew

Homebrew is a package manager for macOS. Open Terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, add Homebrew to your PATH:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

## Step 2: Install ASDF Version Manager

ASDF is a tool version manager that we'll use to manage Erlang and Elixir versions:

```bash
brew install asdf
```

Add ASDF to your shell:

```bash
echo '. "$(brew --prefix asdf)/libexec/asdf.sh"' >> ~/.zshrc
source ~/.zshrc
```

Add these helpful aliases to your `.zshrc`:

1. Open `.zshrc` in vim:
```bash
vim ~/.zshrc
```

2. Add these aliases to the file:
```bash
# Neovim aliases
alias vim=nvim
alias vi=nvim
alias nv=nvim

# Git aliases
alias gs="git status --short"
alias go="git checkout "
alias ga="git add "
alias gp="git push -u origin "
alias gl="git pull origin "
alias gc="git commit "
alias gh="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gf="git fetch"
alias glu="git pull upstream"
alias gm="git merge "
alias gb="git checkout -"
alias gst="git stash"
alias gstp="git stash pop"
alias gstm="git stash push -m"
alias gd="git diff "
alias gr="git rebase "

# Mix and Phoenix aliases
alias ms="iex -S mix phx.server"
alias mps="mix phx.server"
alias mem="mix ecto.migrate"
alias megm="mix ecto.gen.migration"
alias mrr="mix ecto.reset && mix ecto.realistic"
alias mrd="mix ecto.reset && mix ecto.demo"
alias md="mix deps.get"
```

3. Save and quit vim (press `ESC`, then type `:wq` and hit `Enter`)

4. Reload your shell configuration:
```bash
source ~/.zshrc
```

## Step 3: Install Erlang Dependencies

The essential dependency for Erlang:

```bash
# Required for Erlang's crypto and SSL functionality
brew install openssl@1.1
```

## Step 4: Install Erlang

Now we can install Erlang using ASDF:

```bash
# Add the Erlang plugin
asdf plugin add erlang

# Install the latest Erlang version
asdf install erlang latest

# Set it as the global version
asdf global erlang latest
```

## Step 5: Install Elixir

With Erlang installed, we can now install Elixir:

```bash
# Add the Elixir plugin
asdf plugin add elixir

# Install the latest Elixir version
asdf install elixir latest

# Set it as the global version
asdf global elixir latest
```

## Step 6: Install PostgreSQL

For Phoenix applications, you'll need PostgreSQL:

```bash
brew install postgresql@14

# Start PostgreSQL service
brew services start postgresql@14
```

## Step 7: Install Phoenix Framework

Now that we have Elixir installed, we can install the Phoenix Framework:

```bash
mix local.hex --force
mix archive.install hex phx_new
```

## Step 8: Install Node.js (Required for Phoenix Assets)

Install Node.js using ASDF:

```bash
# Add Node.js plugin
asdf plugin add nodejs

# Install latest Node.js version
asdf install nodejs latest

# Set it as global version
asdf global nodejs latest
```

## Step 9: Install Development Tools

Install some additional development tools:

```bash
# Install git if not already installed
brew install git
```

## Step 10: Verify Installation

Verify that everything is installed correctly:

```bash
# Check Erlang version
erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'

# Check Elixir version
elixir --version

# Check Phoenix version
mix phx.new --version

# Check PostgreSQL version
psql --version
```

## Creating Your First Phoenix Project

Now you're ready to create your first Phoenix project:

```bash
# Create a new Phoenix project
mix phx.new my_app

# Change into the project directory
cd my_app

# Create and migrate the database
mix ecto.create
mix ecto.migrate

# Install dependencies and assets
mix deps.get
mix assets.deploy

# Start the Phoenix server
mix phx.server
```

Visit [`localhost:4000`](http://localhost:4000) in your browser to see your Phoenix application running!

## Troubleshooting

### Common Issues and Solutions

1. **Erlang Installation Fails**
   - Make sure all dependencies are installed
   - Try running `brew doctor` to check for system issues
   - Ensure XCode Command Line Tools are installed: `xcode-select --install`

2. **PostgreSQL Connection Issues**
   - Ensure PostgreSQL service is running: `brew services list`
   - Check if PostgreSQL user exists: `createuser -s postgres`

3. **Phoenix Server Won't Start**
   - Check if PostgreSQL is running
   - Ensure all dependencies are installed: `mix deps.get`
   - Make sure database is created: `mix ecto.create`
