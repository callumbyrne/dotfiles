return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()

      local on_attach = require("nvchad.configs.lspconfig").on_attach
      local on_init = require("nvchad.configs.lspconfig").on_init
      local capabilities = require("nvchad.configs.lspconfig").capabilities

      local lspconfig = require "lspconfig"
      local servers = {
        "html",
        "cssls",
        "ts_ls",
        "gopls",
      }

      -- lsps with default config
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
        }
      end

      lspconfig.jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            validate = { enable = true },
            format = { enable = true },
          },
        },
        -- Lazy-load schemas.
        on_new_config = function(config)
          config.settings.json.schemas = config.settings.json.schemas or {}
          vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
        end,
      }
    end,
  },
}
