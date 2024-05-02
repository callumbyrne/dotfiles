return {
  -- add gruvbox
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   opts = {
  --     bold = false,
  --     italic = {
  --       strings = false,
  --       emphasis = false,
  --       comments = false,
  --       operators = false,
  --       folds = false,
  --     },
  --     overrides = {
  --       -- Highlight symbol under cursor
  --       IlluminatedWordText = { bg = "#444444", bold = false },
  --       IlluminatedWordRead = { bg = "#444444", bold = false },
  --       IlluminatedWordWrite = { bg = "#444444", bold = false },
  --     },
  --   },
  -- },

  {
    "rebelot/kanagawa.nvim",
    opts = {
      theme = "wave",
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      colorscheme = "kanagawa",
    },
  },
}
