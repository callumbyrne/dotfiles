local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- show references in telescope
autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      map("n", "gr", "<cmd> Telescope lsp_references <CR>", { buffer = args.buf, desc = "LSP references" })
    end)
  end,
})

-- highlight on yank
autocmd("TextYankPost", {
  callback = function()
    require("vim.highlight").on_yank { higroup = "Visual", timeout = 200 }
  end,
  desc = "Highlight when yanking",
})
