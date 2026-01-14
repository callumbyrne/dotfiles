-- credits to original theme for existing https://github.com/nealmckee/penumbra
-- this is a modified version of it

local M = {}

M.base_30 = {
  white = "#3E4044",
  light_grey = "#6d6660",
  grey_fg2 = "#888990", -- 5% darker than grey
  grey_fg = "#82838a", -- 10% darker than grey
  grey = "#909299", -- 40% darker than black
  one_bg3 = "#bec3c9",
  one_bg2 = "#cbcfd6",
  black2 = "#e1e5ea",
  one_bg = "#d8dbe0",
  black = "#f0f4f9",
  darker_black = "#e1e5ea",
  baby_pink = "#CA736C",
  blue = "#6E8DD5",
  cyan = "#00A0BA",
  dark_purple = "#806db8",
  green = "#3ea57b",
  nord_blue = "#5794D0",
  orange = "#BA823A",
  pink = "#CA7081",
  purple = "#ac78bd",
  red = "#ca7081",
  sun = "#A38F2D",
  teal = "#22839b",
  vibrant_green = "#46A473",
  yellow = "#92963a",
  line = "#cdd1d6",
  statusline_bg = "#e1e5ea",
  lightbg = "#e1e5ea",
  pmenu_bg = "#e1e5ea",
  folder_bg = "#717171",
  coal = "#8a8a8a",
}

M.base_16 = {
  base00 = "#f0f4f9",
  base01 = "#e1e5ea",
  base02 = "#d8dbe0",
  base03 = "#CECECE",
  base04 = "#9E9E9E",
  base05 = "#636363",
  base06 = "#3E4044",
  base07 = "#24272B",
  base08 = "#ca7081",
  base09 = "#5a79c1",
  base0A = "#BA823A",
  base0B = "#3ea57b",
  base0C = "#22839b",
  base0D = "#4380bc",
  base0E = "#ac78bd",
  base0F = "#ca7081",
}

M.polish_hl = {
  treesitter = {
    ["@function.builtin"] = { fg = M.base_30.teal },
    ["@variable.member.key"] = { fg = M.base_30.red },
    ["@punctuation.bracket"] = { fg = M.base_30.coal },
    ["@variable.member"] = { fg = M.base_30.coal },
  },

  syntax = {
    Constant = { fg = M.base_30.red },
    Include = { fg = M.base_30.dark_purple },
  },

  telescope = {
    TelescopeSelection = { fg = M.base_30.white, bg = M.base_30.one_bg2 },
    TelescopeSelectionCaret = { fg = M.base_30.blue, bg = M.base_30.one_bg2 },
    TelescopeMultiSelection = { fg = M.base_30.white, bg = M.base_30.one_bg3 },
    TelescopeMatching = { fg = M.base_30.orange },
  },
}

M.type = "light"

M = require("base46").override_theme(M, "new_penumbra_light")

return M
