return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
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
      "templ",

      -- other
      "go",
      "gomod",
      "gowork",
      "gosum",
    },
  },
}
