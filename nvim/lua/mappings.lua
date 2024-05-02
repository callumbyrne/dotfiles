require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- nvimtree
map("n", "<leader>e", function()
  local api = require "nvim-tree.api"
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.tree.focus()
  end
end, { desc = "nvimtree focus/open nvimtree (closes if open)" })

-- true-zen
map("n", "<leader>tf", function()
  require("true-zen").focus()
end, { desc = "Focus mode" })

-- zen-mode
map("n", "<leader>ta", function()
  require("zen-mode").toggle()
end, { desc = "Zen mode" })
