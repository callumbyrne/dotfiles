-- ~/.config/nvim/lua/custom/themes/morning_mist.lua
-- Final version of "Morning Mist", correcting the NvimTree folder color at the source.

---@type Base46Table
local M = {}

-- Set the theme type
M.type = "light"

-- UI Colors
M.base_30 = {
  white = "#4f4a45", -- Main foreground text
  black = "#f4f1ea", -- Main background
  darker_black = "#e9e5de", -- Darker bg shade
  black2 = "#dcd7cd",
  one_bg = "#dcd7cd", -- Darker bg shade 2
  one_bg2 = "#dcd7cd",
  one_bg3 = "#cec8be", -- Darker bg shade 3
  grey = "#a19a92", -- Comments and subtle text
  grey_fg = "#a19a92",
  grey_fg2 = "#6d6660",
  light_grey = "#6d6660",
  red = "#d66868",
  baby_pink = "#d66868",
  pink = "#ac78bd",
  line = "#e9e5de",
  green = "#819b75",
  vibrant_green = "#819b75",
  nord_blue = "#75899b",
  blue = "#75899b",
  seablue = "#6e9a9d",
  yellow = "#d4a36a",
  sun = "#d4a36a",
  purple = "#ac78bd",
  dark_purple = "#ac78bd",
  teal = "#6e9a9d",
  orange = "#c77f6a",
  cyan = "#6e9a9d",
  statusline_bg = "#e9e5de",
  lightbg = "#e9e5de",
  pmenu_bg = "#e9e5de",
  folder_bg = "#717171",
}

-- Syntax Colors
M.base_16 = {
  base00 = "#f4f1ea",
  base01 = "#e9e5de",
  base02 = "#dcd7cd",
  base03 = "#a19a92",
  base04 = "#6d6660",
  base05 = "#4f4a45",
  base06 = "#3a3632",
  base07 = "#2e2b28",
  base08 = "#d66868",
  base09 = "#c77f6a",
  base0A = "#d4a36a",
  base0B = "#819b75",
  base0C = "#6e9a9d",
  base0D = "#75899b",
  base0E = "#ac78bd",
  base0F = "#c77f6a",
}

-- Optional overrides for fine-tuning
M.polish_hl = {
  syntax = {
    Comment = { italic = true },
    Type = { fg = M.base_30.teal },
    PmenuSel = { bg = M.base_30.blue, fg = M.base_30.black },
    CmpBorder = { fg = M.base_30.one_bg3 },
    CmpDocBorder = { link = "CmpBorder" },
    LazyGitFloat = { bg = M.base_30.darker_black, fg = M.base_30.white },
  },

  treesitter = {
    ["@type.builtin"] = { fg = M.base_30.teal, bold = true },
    ["@variable.parameter"] = { fg = M.base_30.purple, italic = true },
    ["@tag"] = { fg = M.base_30.blue },
    ["@tag.attribute"] = { fg = M.base_30.orange, italic = true },
  },
}

-- Allows users to override the theme from their chadrc.lua
M = require("base46").override_theme(M, "morning_mist")

return M
