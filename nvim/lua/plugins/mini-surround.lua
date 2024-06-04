return {
  "echasnovski/mini.surround",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mini.surround").setup {
      n_lines = 50,
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    }
  end,
}
