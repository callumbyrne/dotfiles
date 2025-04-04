return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local configs = require "nvchad.configs.lspconfig"

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

      for name, opts in pairs(servers) do
        opts.on_init = configs.on_init
        opts.on_attach = configs.on_attach
        opts.capabilities = configs.capabilities

        require("lspconfig")[name].setup(opts)
      end
    end,
  },
}
