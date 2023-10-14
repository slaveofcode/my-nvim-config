return {
  {
    'vonheikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'insertenter',
    dependencies = {
      {'l3mon4d3/luasnip'},
    },
    config = function()
      -- here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- and you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      
      cmp.setup({
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ['<c-space>'] = cmp.mapping.complete(),
          ['<c-u>'] = cmp.mapping.scroll_docs(-4),
          ['<c-d>'] = cmp.mapping.scroll_docs(4),
          ['<c-f>'] = cmp_action.luasnip_jump_forward(),
          ['<c-b>'] = cmp_action.luasnip_jump_backward(),
        })
      })
    end
  },

  -- lsp
  {
    'neovim/nvim-lspconfig',
    cmd = {'Lspinfo', 'Lspinstall', 'Lspstart'},
    event = {'bufreadpre', 'bufnewfile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      -- this is where all the lsp shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (optional) configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
          tsserver = function()
            -- custom config for tsserver
            -- require('lspconfig').tsserver.setup({
            --   root_dir = lspconfig.util.root_pattern("package.json"),
            --   init_options = ts_utils.init_options,
            --   on_attach = function(client, bufnr)
            --       client.resolved_capabilities.document_formatting = false
            --       client.resolved_capabilities.document_range_formatting = false
            --       on_attach(client, bufnr)

            --       ts_utils.setup(ts_utils_settings)
            --       ts_utils.setup_client(client)
            --   end,
            --   flags = {
            --       debounce_text_changes = 150,
            --   },
            --   plugins = {
            --       {
            --           name = 'tsconfig-paths',
            --           location = '~/node_modules/tsconfig-paths',
            --       }
            --   },
            --   capabilities = capabilities,
            -- })

            local lspconfig = require('lspconfig')
            lspconfig.tsserver.setup({
              single_file_support = false,
              on_attach = function(client)
                client.resolved_capabilities.document_formatting = false
              end,
              filetypes = { "typescript", "typescriptreact" },
              root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
              settings = {
                typescript = {
                  preferences = {
                    importmodulespecifier = "relative"
                  },
                },
              },
              plugins = {
                  {
                      name = 'tsconfig-paths',
                      location = '~/node_modules/tsconfig-paths',
                  }
              },
            })
          end,
        },
      })
    end
  }
}
