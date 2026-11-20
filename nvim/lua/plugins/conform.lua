return {
  "stevearc/conform.nvim",
  event = "BufWritePre", -- uncomment for format on save
  config = function()
    -- Biome in projects with a biome config, prettier everywhere else.
    local biome_or_prettier = { "biome-check", "prettier", stop_after_first = true }

    local options = {
      formatters_by_ft = {
        lua = { "stylua" },
        css = biome_or_prettier,
        html = { "prettier" },
        templ = { "templ" },
        javascript = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        typescript = biome_or_prettier,
        typescriptreact = biome_or_prettier,
        json = biome_or_prettier,
        jsonc = biome_or_prettier,
        yaml = { "prettier" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        go = { "goimports", "gofumpt" },
      },

      formatters = {
        -- Only treat biome as available when a biome.json(c) is found.
        -- Formats and organizes imports, but doesn't apply lint fixes.
        ["biome-check"] = {
          require_cwd = true,
          append_args = { "--linter-enabled=false" },
        },
      },

      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
    }

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    require("conform").setup(options)
  end,
}
