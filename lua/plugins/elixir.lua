return {
  -- Syntax highlighting and basic Elixir support
  {
    "elixir-editors/vim-elixir",
    ft = { "elixir", "eelixir", "heex" },
  },

  -- LSP configuration for Elixir
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- Add mason for LSP installation management
      {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = ":MasonUpdate",
        opts = {
          ensure_installed = { 
            "elixir-ls",
            "html-lsp"  -- Add HTML LSP for HEEx files
          },
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          automatic_installation = true,
        },
      },
    },
    config = function()
      -- Initialize mason
      require("mason").setup()
      require("mason-lspconfig").setup()

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Remove formatting capabilities from LSP capabilities
      capabilities.documentFormattingProvider = false
      capabilities.documentRangeFormattingProvider = false
      capabilities.documentOnTypeFormattingProvider = false

      -- Create a custom message handler to filter formatter messages
      local elixir_ls_message_handler = function(client_id)
        local client = vim.lsp.get_client_by_id(client_id)
        local original_handler = client.handlers["window/showMessage"]
        local original_diagnostic_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

        -- Override the message handler
        client.handlers["window/showMessage"] = function(err, method, params, client_id)
          -- Filter out formatter-related messages
          if params and params.message then
            local msg = params.message:lower()
            if msg:match("formatter") or 
               msg:match("format") or 
               msg:match("phoenix%.liveview%.htmlformatter") or
               msg:match("please compile") then
              return -- Silently ignore formatter messages
            end
          end
          -- Pass other messages to the original handler
          if original_handler then
            original_handler(err, method, params, client_id)
          end
        end

        -- Override the diagnostic handler
        client.handlers["textDocument/publishDiagnostics"] = function(err, method, params, client_id)
          if params and params.diagnostics then
            local filtered_diagnostics = {}
            for _, diagnostic in ipairs(params.diagnostics) do
              -- Skip any formatter-related diagnostics
              if diagnostic.message then
                local msg = diagnostic.message:lower()
                if not (msg:match("formatter") or 
                       msg:match("format") or 
                       msg:match("phoenix%.liveview%.htmlformatter") or
                       msg:match("please compile")) then
                  table.insert(filtered_diagnostics, diagnostic)
                end
              else
                table.insert(filtered_diagnostics, diagnostic)
              end
            end
            params.diagnostics = filtered_diagnostics
          end
          -- Pass filtered diagnostics to the original handler
          original_diagnostic_handler(err, method, params, client_id)
        end
      end

      -- Configure ElixirLS with absolutely no formatting capabilities
      lspconfig.elixirls.setup({
        cmd = { "elixir-ls" },
        capabilities = capabilities,
        filetypes = { "elixir", "eelixir" },
        root_dir = function(fname)
          return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.fn.getcwd()
        end,
        settings = {
          elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = true,
            suggestSpecs = true,
            -- Explicitly disable formatting in ElixirLS
            formatter = "none",
          },
        },
        on_attach = function(client, bufnr)
          -- Set up the custom message handler
          elixir_ls_message_handler(client.id)
          
          -- Forcefully disable all formatting capabilities
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          client.server_capabilities.documentOnTypeFormattingProvider = false
          
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Key mappings
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        end,
      })

      -- Set up a separate LSP config for HEEx files
      lspconfig.html.setup({
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "heex" },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable formatting capabilities for HTML LSP as well
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        end,
        settings = {
          html = {
            format = {
              enable = false,  -- Disable HTML formatting since we use conform.nvim
            },
            validate = {
              scripts = true,
              styles = true,
            },
          },
        },
      })
    end,
  },

  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ 
            async = true, 
            lsp_fallback = false,
            timeout_ms = 3000
          })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        elixir = { "mix" },
        heex = { "mix" },
        eelixir = { "mix" },
        surface = { "mix" }, -- For Surface templates if you use them
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 3000, -- Increased timeout for larger files
        lsp_fallback = false,
      },
      -- Enable format on save for all configured filetypes
      format_after_save = false, -- Format before save (BufWritePre)
      formatters = {
        mix = {
          command = "mix",
          args = { "format", "-" },
          stdin = true,
          require_cwd = true, -- Ensures we're in a Mix project
          cwd = function(_)
            -- Find the directory containing mix.exs starting from the current buffer's directory
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir = vim.fn.fnamemodify(current_file, ':h')
            local mix_dir = vim.fn.finddir('mix.exs', current_dir .. ';')
            
            -- If mix.exs is found, return its directory
            if mix_dir ~= '' then
              return vim.fn.fnamemodify(mix_dir, ':h')
            end
            
            -- Fallback to current working directory
            return vim.fn.getcwd()
          end,
        },
        prettier = {
          command = "npx",
          args = { "--yes", "prettier", "--stdin-filepath", "$FILENAME" },
          stdin = true,
          cwd = function(ctx)
            -- For sphinx project, look for src directory or package.json
            local current_file = ctx.filename
            local current_dir = vim.fn.fnamemodify(current_file, ':h')
            
            -- Check if we're in the sphinx project
            local sphinx_src = vim.fn.finddir('src', current_dir .. ';')
            if sphinx_src ~= '' then
              -- Find package.json in src directory
              local package_json = vim.fn.findfile('package.json', sphinx_src .. ';')
              if package_json ~= '' then
                return vim.fn.fnamemodify(package_json, ':h')
              end
            end
            
            -- Fallback: look for package.json in current or parent directories
            local package_json = vim.fn.findfile('package.json', current_dir .. ';')
            if package_json ~= '' then
              return vim.fn.fnamemodify(package_json, ':h')
            end
            
            -- Final fallback to current working directory
            return vim.fn.getcwd()
          end,
        },
      },
      -- Explicitly disable LSP formatting
      lsp_fallback = false,
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 },
        }),
        enabled = function()
          -- disable completion in comments
          local context = require 'cmp.config.context'
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment") 
              and not context.in_syntax_group("Comment")
          end
        end,
      })

      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "elixir", "heex", "eex", "html" },
        highlight = { 
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })

      -- Set filetype association
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.html.heex",
        callback = function()
          vim.bo.filetype = "heex"
        end
      })

      -- Force reload of query file
      local ts_query = require('nvim-treesitter.query')
      if ts_query and ts_query.invalidate then
        ts_query.invalidate("elixir")
      end
    end,
  },

  -- Phoenix.vim for navigation
  {
    "c-brenn/phoenix.vim",
    dependencies = { "tpope/vim-projectionist" },
    ft = { "elixir", "eelixir", "heex" },
  },
} 
