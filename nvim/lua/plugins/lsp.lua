return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "templ" },
        },
        cssls = {},
        tsserver = {},
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
      },
      -- This setup function will automatically apply the NvChad defaults
      -- to every server listed above, removing the need for a manual loop.
      setup = {
        ["*"] = function(server_name, opts)
          local configs = require "nvchad.configs.lspconfig"

          opts.on_init = configs.on_init
          opts.on_attach = configs.on_attach
          opts.capabilities = configs.capabilities

          -- Return false to let nvim-lspconfig continue with its own setup
          return false
        end,
      },
    },
  },
}
