local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set

-- show references in telescope
augroup("LspConfig", { clear = true })
autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      map("n", "gr", "<cmd> Telescope lsp_references <CR>", { buffer = args.buf, desc = "LSP references [Telescope]" })
    end)
  end,
})

-- Go settings
augroup("GoSettings", { clear = true })
autocmd("FileType", {
  pattern = "go",
  group = "GoSettings",
  callback = function()
    -- Set indentation to 4 columns for tab characters
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4

    -- IMPORTANT: Use real tabs, not spaces, for Go
    vim.opt_local.expandtab = false
  end,
})

-- highlight on yank
-- autocmd("TextYankPost", {
--   callback = function()
--     require("vim.highlight").on_yank { higroup = "Visual", timeout = 200 }
--   end,
--   desc = "Highlight when yanking",
-- })
