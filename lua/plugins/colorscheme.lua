return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        dim_inactive = false,
        lualine_bold = false,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,         -- do not set background color
        dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        theme = "wave",              -- Load "wave" theme when 'background' is dark
        background = {               -- map the value of 'background' option to a theme
          dark = "wave",           
          light = "lotus"
        },
      })
    end,
  },
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      -- Sonokai configuration
      vim.g.sonokai_style = 'andromeda'  -- Available styles: 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_transparent_background = 1
      vim.g.sonokai_diagnostic_text_highlight = 1
      vim.g.sonokai_diagnostic_line_highlight = 1
      vim.g.sonokai_diagnostic_virtual_text = 1
    end,
  },
  {
    "joshdick/onedark.vim",
    priority = 1000,
    config = function()
      -- One Dark configuration
      vim.g.onedark_terminal_italics = 1
      vim.g.onedark_termcolors = 256
      vim.g.onedark_hide_endofbuffer = 1
      -- Make background transparent
      if vim.fn.has("autocmd") == 1 and vim.fn.has("gui_running") == 0 then
        vim.cmd([[
          augroup TransparentBackground
            autocmd!
            autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
          augroup END
        ]])
      end
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      -- Dracula configuration
      require("dracula").setup({
        -- show the '~' characters after the end of buffers
        show_end_of_buffer = false,
        -- use transparent background
        transparent_bg = true,
        -- set italic comment
        italic_comment = true,
        -- set custom lualine background color
        lualine_bg_color = "#44475a",
        -- Override colors if needed
        colors = {
          bg = "#282A36",
          fg = "#F8F8F2",
          selection = "#44475A",
          comment = "#6272A4",
          red = "#FF5555",
          orange = "#FFB86C",
          yellow = "#F1FA8C",
          green = "#50fa7b",
          purple = "#BD93F9",
          cyan = "#8BE9FD",
          pink = "#FF79C6",
        },
      })
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      -- VSCode theme configuration
      require('vscode').setup({
        -- Enable transparent background
        transparent =  true,
        -- Enable italic comment
        italic_comments = true,
        -- Underline `@markup.link.*` variants
        underline_links = true,
        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
        -- Enable terminal colors
        terminal_colors = true,
      })

      -- Create commands to switch between themes
      vim.api.nvim_create_user_command('TokyoNight', function()
        vim.cmd.colorscheme('tokyonight-night')
      end, {})

      vim.api.nvim_create_user_command('Catppuccin', function()
        vim.cmd.colorscheme('catppuccin')
      end, {})

      vim.api.nvim_create_user_command('Kanagawa', function()
        vim.cmd.colorscheme('kanagawa')
      end, {})

      vim.api.nvim_create_user_command('Sonokai', function()
        vim.cmd.colorscheme('sonokai')
      end, {})

      vim.api.nvim_create_user_command('OneDark', function()
        vim.cmd.colorscheme('onedark')
      end, {})

      vim.api.nvim_create_user_command('Dracula', function()
        vim.cmd.colorscheme('dracula')
      end, {})

      vim.api.nvim_create_user_command('VSCode', function()
        vim.cmd.colorscheme('vscode')
      end, {})

      -- Set default colorscheme
      vim.cmd.colorscheme('vscode')
    end,
  },
} 
