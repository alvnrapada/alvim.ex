return {
  'stevearc/aerial.nvim',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("aerial").setup({
      -- Elixir-specific settings
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
      },
      -- Show box drawing characters for the tree hierarchy
      show_guides = true,
      
      -- Customize the characters used when show_guides = true
      guides = {
        -- When the child item has a sibling below it
        mid_item = "├─",
        -- When the child item is the last in the list
        last_item = "└─",
        -- When there are nested child guides to the right
        nested_top = "│ ",
        -- Raw indentation
        whitespace = "  ",
      },
      
      -- Keymaps in aerial window
      keymaps = {
        ["?"] = "actions.show_help",
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["p"] = "actions.scroll",
        ["<C-j>"] = "actions.down_and_scroll",
        ["<C-k>"] = "actions.up_and_scroll",
        ["{"] = "actions.prev",
        ["}"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
        ["q"] = "actions.close",
        ["o"] = "actions.tree_toggle",
        ["za"] = "actions.tree_toggle",
        ["O"] = "actions.tree_toggle_recursive",
        ["zA"] = "actions.tree_toggle_recursive",
        ["l"] = "actions.tree_open",
        ["zo"] = "actions.tree_open",
        ["L"] = "actions.tree_open_recursive",
        ["zO"] = "actions.tree_open_recursive",
        ["h"] = "actions.tree_close",
        ["zc"] = "actions.tree_close",
        ["H"] = "actions.tree_close_recursive",
        ["zC"] = "actions.tree_close_recursive",
        ["zr"] = "actions.tree_increase_fold_level",
        ["zR"] = "actions.tree_open_all",
        ["zm"] = "actions.tree_decrease_fold_level",
        ["zM"] = "actions.tree_close_all",
        ["zx"] = "actions.tree_sync_folds",
        ["zX"] = "actions.tree_sync_folds",
      },
      
      -- When true, don't load aerial until a command or function is called
      lazy_load = false,
      
      -- Disable aerial on files with this many lines
      disable_max_lines = 10000,
      
      -- Disable aerial on files this size or larger (in bytes)
      disable_max_size = 2000000, -- 2MB
      
      -- A list of all symbols to display. Set to false to display all symbols.
      -- This can be a filetype map (see :help aerial-filetype-map)
      -- To see all available values, see :help SymbolKind
      filter_kind = false,
      
      -- Determines line highlighting mode when multiple splits are visible
      -- split_width   Each open window will have its own highlighting
      -- full_width    One window will be highlighted per tab page
      -- last          Only the most-recently focused window will be highlighted
      -- none          No highlighting
      highlight_mode = "split_width",
      
      -- Options for opening aerial in a floating win
      float = {
        -- Controls border appearance. Passed to nvim_open_win
        border = "rounded",
        
        -- Determines location of floating window
        --   cursor - Opens float on top of cursor
        --   editor - Opens float centered in editor
        --   win    - Opens float centered in window
        relative = "cursor",
        
        -- These control the height of the floating window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a list of mixed types.
        -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },
      },
    })
    
    -- Key mappings for aerial
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial (Code Outline)' })
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { desc = 'Jump to previous symbol' })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { desc = 'Jump to next symbol' })
    vim.keymap.set('n', '[[', '<cmd>AerialPrevUp<CR>', { desc = 'Jump to previous parent symbol' })
    vim.keymap.set('n', ']]', '<cmd>AerialNextUp<CR>', { desc = 'Jump to next parent symbol' })
  end
}