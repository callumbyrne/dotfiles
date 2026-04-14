-- ABOUTME: Defines a muted light Base46 theme based on Zed's One Light palette.
-- ABOUTME: Keeps NvChad's one_light highlight structure while swapping in Zed colors.

local M = {}

M.base_30 = {
  white = "#54555b",
  darker_black = "#efeff0",
  black = "#fafafa", --  nvim bg
  black2 = "#EAEAEB",
  one_bg = "#dadadb", -- real bg of onedark
  one_bg2 = "#d4d4d5",
  one_bg3 = "#cccccd",
  grey = "#b7b7b8",
  grey_fg = "#b0b0b1",
  grey_fg2 = "#a9a9aa",
  light_grey = "#a2a2a3",
  red = "#d36151",
  baby_pink = "#d36151",
  pink = "#a449ab",
  line = "#e2e2e2", -- for lines like vertsplit
  green = "#649f57",
  vibrant_green = "#669f59",
  nord_blue = "#3882b7",
  blue = "#5c78e2",
  yellow = "#c18401",
  sun = "#a48819",
  purple = "#a449ab",
  dark_purple = "#7274a7",
  teal = "#0997b3",
  orange = "#ad6e25",
  cyan = "#3882b7",
  statusline_bg = "#ececec",
  lightbg = "#d3d3d3",
  pmenu_bg = "#5e5f65",
  folder_bg = "#6C6C6C",
}

M.base_16 = {
  base00 = "#fafafa",
  base01 = "#f4f4f4",
  base02 = "#e5e5e6",
  base03 = "#dfdfe0",
  base04 = "#d7d7d8",
  base05 = "#383a42",
  base06 = "#202227",
  base07 = "#090a0b",
  base08 = "#d36151",
  base09 = "#ad6e25",
  base0A = "#c18401",
  base0B = "#649f57",
  base0C = "#3882b7",
  base0D = "#5c78e2",
  base0E = "#a449ab",
  base0F = "#986801",
}

M.type = "light"

M.polish_hl = {
  telescope = {
    TelescopePromptPrefix = { fg = M.base_30.white },
    TelescopeSelection = { bg = M.base_30.one_bg, fg = M.base_30.white },
  },

  treesitter = {
    ["@punctuation.bracket"] = { fg = M.base_30.nord_blue },
  },

  defaults = {
    FloatBorder = { fg = M.base_16.base05 },
    Pmenu = { bg = M.base_30.black2 },
  },

  git = {
    DiffAdd = { fg = M.base_16.base05 },
  },

  tbline = {
    TbLineThemeToggleBtn = { bg = M.base_30.one_bg3 },
  },

  whichkey = { WhichKeyDesc = { fg = M.base_30.white } },
  statusline = { St_pos_text = { fg = M.base_30.white } },
}

M = require("base46").override_theme(M, "zed_one_light")

return M
