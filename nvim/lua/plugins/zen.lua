return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.93,
        width = 140,
        height = 1,
      },
      plugins = {
        options = {
          showcmd = true, -- disables the command in the last line of the screen
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
      },
    },
  },
  {
    "pocco81/true-zen.nvim",
  },
}
