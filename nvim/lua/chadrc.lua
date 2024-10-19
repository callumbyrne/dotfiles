-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "everforest",

  statusline = {
    separator_style = "block",
  },

  mason = {
    pkgs = {
      "lua-language-server",
      "stylua",
      "html-lsp",
      "css-lsp",
      "prettier",
      "typescript-language-server",
      "gopls",
      "goimports",
      "gofumpt",
      "gomodifytags",
      "eslint_d",
      "json-lsp",
    },
  },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

return M
