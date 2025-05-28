-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Move leader key setup to the top, before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup plugins
require("lazy").setup({
  -- Import all plugins from the plugins directory
  { import = "plugins" },
  
  -- FZF setup
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = function()
      -- FZF configuration
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
      -- Use ripgrep if available
      if vim.fn.executable('rg') == 1 then
        vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
      end
      -- Set up key mapping
      vim.keymap.set('n', '<leader>f', ':FZF<CR>', { silent = true, noremap = true })
    end
  },
  
  -- Your existing plugins
  "tpope/vim-unimpaired",
  "scrooloose/nerdtree",
  "tpope/vim-scriptease",
  "tpope/vim-fugitive",
  "tpope/vim-commentary",
  "vim-scripts/closetag.vim",
  "vim-airline/vim-airline",
  "Yggdroot/indentLine",
  "mhinz/vim-grepper",
  "janko-m/vim-test",
  "mxw/vim-jsx",
  "storyn26383/vim-vue",
  "hail2u/vim-css3-syntax",
  "digitaltoad/vim-pug",
  "isRuslan/vim-es6",
  "cakebaker/scss-syntax.vim",
  "pangloss/vim-javascript",
  "mattn/emmet-vim",
  "dense-analysis/ale",
  -- Themes
  require("plugins.colorscheme"),
})

-- General Settings
vim.opt.clipboard = "unnamed"
vim.cmd("syntax on")
vim.cmd("filetype on")
vim.opt.paste = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.backspace = "indent,eol,start"
vim.opt.mouse = "ia"
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 0

-- Undo settings
vim.opt.undofile = true

-- Key mappings
vim.keymap.set('x', 'p', 'pgvy') -- Paste multiple times
vim.keymap.set('n', '<CR>', ':nohlsearch<CR>')

-- Insert mode navigation
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')

-- Terminal mappings
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-v><Esc>', '<Esc>')

-- Common mappings
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', 'ss', ':update<CR>')
vim.keymap.set('n', 'qq', ':q<CR>')
vim.keymap.set('n', '<tab>', '<c-w>w')

-- Window navigation
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- Leader mappings
vim.keymap.set('n', '<leader>gs', '<cmd>GFiles?<CR>')
vim.keymap.set('n', '<leader>ag', '<cmd>Ag<CR>')
vim.keymap.set('n', '<leader>rg', '<cmd>Rg<CR>')
vim.keymap.set('n', '<leader>n', '<cmd>NERDTreeToggle<CR>')
vim.keymap.set('n', '<leader>mv', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>ms', '<cmd>split<CR>')
vim.keymap.set('n', '<leader>z', '<C-Z>')
vim.keymap.set('n', '<leader>g', '<C-O>')

-- Fugitive mappings
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit!<CR>')
vim.keymap.set('n', 'gdh', '<cmd>diffget //2<CR>')
vim.keymap.set('n', 'gdl', '<cmd>diffget //3<CR>')

-- Terminal mappings
vim.keymap.set('n', '<leader>ts', '<cmd>split | terminal<CR>')
vim.keymap.set('n', '<leader>tv', '<cmd>vsplit | terminal<CR>')
vim.keymap.set('n', '<leader>tp', '<cmd>split | terminal mix phx.server<CR>')
vim.keymap.set('n', '<leader>tg', '<cmd>split | terminal mix deps.get<CR>')
vim.keymap.set('n', '<leader>tm', '<cmd>split | terminal mix ecto.migrate<CR>')

-- Add mix xref callers mapping
vim.keymap.set('n', '<leader>mx', function()
  -- Get all lines from current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local module_name = ""
  
  -- Find the defmodule line and extract module name
  for _, line in ipairs(lines) do
    local match = line:match("^%s*defmodule%s+([%w%.]+)%s+do%s*$")
    if match then
      module_name = match
      break
    end
  end
  
  vim.ui.input({ prompt = 'Module name: ', default = module_name }, function(input_module)
    if input_module then
      vim.cmd('botright vsplit | terminal mix xref callers ' .. input_module)
    end
  end)
end)

-- Tab navigation
vim.keymap.set('n', '<leader>gn', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<leader>gp', '<cmd>tabprevious<CR>')

-- ALE settings
vim.g.ale_linters = {
  javascript = {'eslint', 'tslint'},
  typescript = {'eslint', 'tslint'},
  elixir = {'credo'}
}

vim.g.ale_elixir_credo_strict = 1
vim.g.ale_linters_explicit = 1
vim.g.ale_set_highlights = 1
vim.g.ale_sign_error = '🚫'
vim.g.ale_sign_warning = '⚠️'
vim.g.ale_completion_enabled = 0  -- Disable ALE completion since we use nvim-cmp
vim.g.ale_sign_column_always = 1
vim.g.ale_lint_on_text_changed = 'never'  -- Disable linting on text change
vim.g.ale_lint_on_save = 0  -- Disable linting on save
vim.g.ale_lint_on_enter = 0
vim.g.ale_lint_on_filetype_changed = 0
vim.g.ale_fix_on_save = 0  -- Disable fixing on save

-- Vim-test mappings
vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<CR>')
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<CR>')
vim.keymap.set('n', '<leader>tg', '<cmd>TestVisit<CR>')
vim.keymap.set('n', '<leader>tt', '<cmd>TestFile<CR>')
vim.keymap.set('n', '<leader>ta', '<cmd>TestSuite<CR>')

-- Vim-test settings
vim.g['test#preserve_screen'] = 0
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'tabnew'
vim.g['test#elixir#exunit#options'] = '--trace'

-- Autocommands
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "/tmp/*",
  command = "setlocal noundofile"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "text",
  command = "setlocal textwidth=78"
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd("normal g'\"")
    end
  end
}) 
