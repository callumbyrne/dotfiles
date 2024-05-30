return {
  "hrsh7th/nvim-cmp",
  config = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    opts.mapping = vim.tbl_extend("force", {}, opts.mapping, {
      -- Overload tab to accept Copilot suggestions.
      ["<Tab>"] = cmp.mapping(function(fallback)
        local copilot = require "copilot.suggestion"

        if copilot.is_visible() then
          copilot.accept()
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      -- toggle docs
      ["<C-d>"] = function()
        if cmp.visible_docs() then
          cmp.close_docs()
        else
          cmp.open_docs()
        end
      end,
    })

    require("cmp").setup(opts)
  end,
}
