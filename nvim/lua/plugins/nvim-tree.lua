return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    view = {
      width = 50,
    },
    git = {
      ignore = false,
    },
    filesystem_watchers = {
      ignore_dirs = {
        "node_modules",
      },
    },
  },
}
