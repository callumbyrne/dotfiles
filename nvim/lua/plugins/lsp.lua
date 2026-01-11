return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local configs = require "nvchad.configs.lspconfig"

      configs.defaults()

      local servers = {
        html = {
          filetypes = { "html", "templ" },
        },
        cssls = {},
        ts_ls = {},
        gopls = {},
        templ = {},
        htmx = {
          filetypes = { "html", "templ" },
        },
        tailwindcss = {
          filetypes = { "templ", "astro", "javascript", "typescript", "react" },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                templ = "html",
              },
            },
          },
        },
        jsonls = {
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
        },
      }

      for server_name, server_opts in pairs(servers) do
        vim.lsp.config(server_name, vim.tbl_deep_extend("force", {
          on_init = configs.on_init,
          on_attach = configs.on_attach,
          capabilities = configs.capabilities,
        }, server_opts))
        vim.lsp.enable(server_name)
      end
    end,
  },
}
