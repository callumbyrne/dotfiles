-- stylua: ignore start
require "nvchad.mappings"

-- Disable mappings
local nomap = vim.keymap.del

-- to get ctrl-i to work
nomap("n", "<tab>")
nomap("n", "<leader>b")
nomap("n", "<leader>x")

-- Add mappings
local map = vim.keymap.set
local wk = require "which-key"

-- WhichKey
wk.register {
  ["<leader>"] = {
    q = { name = "+session" },
    b = { name = "+buffer" },
  },
}

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer new" })
map("n", "<leader>bd", function() require("nvchad.tabufline").close_buffer() end, { desc = "Close buffer" })
map("n", "<leader>bD", function() require("nvchad.tabufline").closeAllBufs() end, { desc = "Close all buffers" })
map("n", "<leader>bc", function() require("nvchad.tabufline").closeOtherBufs() end, { desc = "Close all buffers except current" })
map("n", "<leader>bl", function() require("nvchad.tabufline").closeBufs_at_direction("left") end, { desc = "Close all buffers to the left" })
map("n", "<leader>br", function() require("nvchad.tabufline").closeBufs_at_direction("right") end, { desc = "Close all buffers to the right" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- telescope
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })

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
map("n", "<leader>tf", function() require("true-zen").focus() end, { desc = "Focus mode" })
-- zen-mode
map("n", "<leader>ta", function() require("zen-mode").toggle() end, { desc = "Zen mode" })

-- persistence
map("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
map("n", "<leader>ql", function() require("persistence").load { last = true } end, { desc = "Restore Last Session" })
map("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })

-- neogit
map("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = 'Git status' })
map("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = 'Git commit' })
map("n", "<leader>gp", "<cmd>Neogit pull<cr>", { desc = 'Git pull' })
map("n", "<leader>gP", "<cmd>Neogit pull<cr>", { desc = 'Git push' })
