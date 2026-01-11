-- ~/.config/nvim/lua/custom/themes/morning_mist.lua
-- Final version of "Morning Mist", correcting the NvimTree folder color at the source.

---@type Base46Table
local M = {}

-- Set the theme type
M.type = "light"

-- UI Colors
M.base_30 = {
  white = "#575b5f", -- Main foreground text
  black = "#f0f4f9", -- usually your theme bg
  darker_black = "#e1e5ea", -- 6% lighter than black
  black2 = "#e1e5ea", -- 6% darker than black
  one_bg = "#d8dbe0", -- 10% darker than black
  one_bg2 = "#cbcfd6", -- 6% darker than one_bg
  one_bg3 = "#bec3c9", -- 6% darker than one_bg2
  grey = "#909299", -- 40% darker than black
  grey_fg = "#82838a", -- 10% darker than grey
  grey_fg2 = "#888990", -- 5% darker than grey
  light_grey = "#6d6660",
  red = "#c95f5f",
  baby_pink = "#c95f5f",
  pink = "#ac78bd",
  line = "#cdd1d6",
  green = "#819b75",
  vibrant_green = "#819b75",
  nord_blue = "#75899b",
  blue = "#75899b",
  seablue = "#575b5f",
  yellow = "#575b5f",
  sun = "#575b5f",
  purple = "#ac78bd",
  dark_purple = "#ac78bd",
  teal = "#575b5f",
  orange = "#575b5f",
  cyan = "#575b5f",
  statusline_bg = "#e1e5ea",
  lightbg = "#e1e5ea",
  pmenu_bg = "#e1e5ea",
  folder_bg = "#717171",
}

-- Syntax Colors
M.base_16 = {
  base00 = "#f0f4f9",
  base01 = "#e1e5ea",
  base02 = "#d8dbe0",
  base03 = "#a19a92",
  base04 = "#6d6660",
  base05 = "#575b5f",
  base06 = "#3a3632",
  base07 = "#2e2b28",
  base08 = "#575b5f",
  base09 = "#575b5f",
  base0A = "#575b5f",
  base0B = "#188038",
  base0C = "#575b5f",
  base0D = "#996900",
  base0E = "#8430ce",
  base0F = "#575b5f",
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
M = require("base46").override_theme(M, "gemini")

return M
