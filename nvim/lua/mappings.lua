-- stylua: ignore start
require "nvchad.mappings"

-- Disable mappings -----------------------------------------
local nomap = vim.keymap.del

-- to get ctrl-i to work
nomap("n", "<tab>")
nomap("n", "<leader>b")
nomap("n", "<leader>x")

-- disable terminal mappings
nomap("n", "<leader>h")
nomap("n", "<leader>v")

-- disable default telescope mappings
nomap("n", "<leader>fw")
nomap("n", "<leader>fb")
nomap("n", "<leader>fh")
nomap("n", "<leader>ma")
nomap("n", "<leader>fo")
nomap("n", "<leader>fz")
nomap("n", "<leader>cm")
nomap("n", "<leader>gt")
nomap("n", "<leader>pt")
nomap("n", "<leader>th")
nomap("n", "<leader>ff")
nomap("n", "<leader>fa")

-- Add mappings ---------------------------------------------
local map = vim.keymap.set
local wk = require "which-key"

-- WhichKey
wk.register {
  ["<leader>"] = {
    t = { name = "+telescope" },
    s = { name = "+session" },
    b = { name = "+buffer" },
    g = { name = "+git" },
    d = { name = "+debug" },
    a = { name = "+ai" },
    x = { name = "+trouble" },
  },
}

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Line diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Keeping the cursor centered.
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
map('n', 'n', 'nzzzv', { desc = 'Next result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- Use jq to format JSON
map('n', '<leader>jq', ':%!jq .<cr>', { desc = 'Format current buffer using JQ' })

-- telescope
map("n", "<leader>tg", "<cmd>Telescope live_grep<CR>", { desc = "Grep search" })
map("n", "<leader>tb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>tH", "<cmd>Telescope help_tags<CR>", { desc = "Help" })
map("n", "<leader>tm", "<cmd>Telescope marks<CR>", { desc = "Find marks" })
map("n", "<leader>tr", "<cmd>Telescope oldfiles<CR>", { desc = "Recently opened files" })
map("n", "<leader>tf", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })
map("n", "<leader>tc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
map("n", "<leader>ts", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "Nvchad themes" })
map("n", "<leader>tt", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map(
  "n",
  "<leader>ta",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Find all files" }
)

-- buffers
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer new" })
map("n", "<S-h>", function() require("nvchad.tabufline").prev() end, { desc = "Prev Buffer" })
map("n", "<S-l>", function() require("nvchad.tabufline").next() end, { desc = "Next Buffer" })
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

-- zen
map("n", "<leader>hf", function() require("true-zen").focus() end, { desc = "Focus mode" })
map("n", "<leader>ha", function() require("zen-mode").toggle() end, { desc = "Zen mode" })

-- persistence
map("n", "<leader>ss", function() require("persistence").load() end, { desc = "Restore Session" })
map("n", "<leader>sl", function() require("persistence").load { last = true } end, { desc = "Restore Last Session" })
map("n", "<leader>sd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })

-- neogit
map("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = 'Git status' })
map("n", "<leader>gp", "<cmd>Neogit pull<cr>", { desc = 'Git pull' })

-- trouble
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true, desc = 'Workspace Diagnostics [Trouble]' })
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { silent = true, noremap = true, desc = 'Buffer Diagnostics [Trouble]' })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { silent = true, noremap = true, desc = 'Symbols [Trouble]' })

-- Toggle the quickfix/loclist window.
-- When toggling these, ignore error messages and restore the cursor to the original window when opening the list.
local silent_mods = { mods = { silent = true, emsg_silent = true } }
vim.keymap.set('n', '<leader>xx', function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        vim.cmd.cclose(silent_mods)
    elseif #vim.fn.getqflist() > 0 then
        local win = vim.api.nvim_get_current_win()
        vim.cmd.copen(silent_mods)
        if win ~= vim.api.nvim_get_current_win() then
            vim.cmd.wincmd 'p'
        end
    end
end, { desc = 'Toggle quickfix list' })
vim.keymap.set('n', '<leader>xl', function()
    if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
        vim.cmd.lclose(silent_mods)
    elseif #vim.fn.getloclist(0) > 0 then
        local win = vim.api.nvim_get_current_win()
        vim.cmd.lopen(silent_mods)
        if win ~= vim.api.nvim_get_current_win() then
            vim.cmd.wincmd 'p'
        end
    end
end, { desc = 'Toggle location list' })

-- enable/disable copilot
map('n', '<leader>ae', '<cmd>Copilot enable<CR>', { desc = 'Enable [Copilot]' })
map('n', '<leader>ad', '<cmd>Copilot disable<CR>', { desc = 'Disable [Copilot]' })

-- diffview
map("n", "<leader>gd", function ()
  if next(require("diffview.lib").views) == nil then
    vim.cmd "DiffviewOpen"
  else
    vim.cmd "DiffviewClose"
  end
end, { desc = "Git Diff [DiffView]" })
map("n", "<leader>gh", function ()
  if next(require("diffview.lib").views) == nil then
    vim.cmd "DiffviewFileHistory %"
  else
    vim.cmd "DiffviewClose"
  end
end, { desc = "Git history [DiffView]" })
