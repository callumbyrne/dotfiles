-- Better copy/pasting.
return {
  "gbprod/yanky.nvim",
  opts = {
    ring = { history_length = 20 },
    highlight = {
      on_put = false,
      on_yank = true,
      timer = 200,
    },
  },
  keys = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
    { "=p", "<Plug>(YankyPutAfterLinewise)", desc = "Put yanked text in line below" },
    { "=P", "<Plug>(YankyPutBeforeLinewise)", desc = "Put yanked text in line above" },
    { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
    { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yanky yank" },
  },
  config = function(_, opts)
    require("yanky").setup(opts)

    -- change the highlight style
    vim.api.nvim_set_hl(0, "YankyYanked", { link = "Visual" })

    --- auto update the highlight style on colorscheme change
    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
      pattern = { "*" },
      callback = function(ev)
        vim.api.nvim_set_hl(0, "YankyYanked", { link = "Visual" })
      end,
    })
  end,
}
