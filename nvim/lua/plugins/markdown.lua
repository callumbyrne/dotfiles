return {
  {
    "MeanderingProgrammer/markdown.nvim", -- Markdown syntax highlighting
    -- enabled = false,
    ft = { "markdown" },
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      bullets = { "•", "○", "◆", "◇" },
      checkbox = {
        -- Character that will replace the [ ] in unchecked checkboxes
        unchecked = "󰄱 ",
        -- Character that will replace the [x] in checked checkboxes
        checked = " ",
      },
    },
  },
}
