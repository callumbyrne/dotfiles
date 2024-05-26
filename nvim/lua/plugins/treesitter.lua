return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- defaults
      "vim",
      "lua",
      "vimdoc",
      "json",
      "yaml",
      "toml",
      "bash",
      "markdown",
      "dockerfile",
      "gitignore",
      "sql",

      -- web dev
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",

      -- other
      "go",
    },
  },
}
