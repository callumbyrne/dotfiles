local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      map("n", "gr", "<cmd> Telescope lsp_references <CR>", { buffer = args.buf, desc = "LSP references" })
    end)
  end,
})
