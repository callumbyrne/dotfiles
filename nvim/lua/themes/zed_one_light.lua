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

-- Each slot names the Zed "One Light" syntax role it is drawn from.
M.base_16 = {
  base00 = "#fafafa", -- editor.background
  base01 = "#f4f4f4",
  base02 = "#e5e5e6",
  base03 = "#dfdfe0",
  base04 = "#d7d7d8",
  base05 = "#242529", -- editor.foreground, variable, namespace
  base06 = "#202227",
  base07 = "#090a0b",
  base08 = "#d3604f", -- property, variable.parameter
  base09 = "#ad6e25", -- number, boolean, variable.special
  base0A = "#3882b7", -- type, enum
  base0B = "#649f57", -- string
  base0C = "#5c78e2", -- constructor
  base0D = "#5b79e3", -- function
  base0E = "#a449ab", -- keyword, preproc
  base0F = "#4d4f52", -- punctuation.bracket, punctuation.delimiter
}

M.type = "light"

-- Zed splits some roles that Base46 shares between one slot, so the groups that
-- would otherwise inherit the wrong slot are pinned to their Zed color here.
M.polish_hl = {
  telescope = {
    TelescopePromptPrefix = { fg = M.base_30.white },
    TelescopeSelection = { bg = M.base_30.one_bg, fg = M.base_30.white },
  },

  treesitter = {
    ["@module"] = { fg = M.base_16.base05 }, -- namespace
    ["@operator"] = { fg = M.base_30.cyan }, -- operator
    ["@constant"] = { fg = M.base_30.yellow }, -- constant

    -- Zed paints every keyword flavour with the one purple.
    ["@keyword.exception"] = { fg = M.base_16.base0E },
    ["@keyword.repeat"] = { fg = M.base_16.base0E },
    ["@keyword.storage"] = { fg = M.base_16.base0E },
    ["@keyword.directive"] = { fg = M.base_16.base0E },

    ["@tag"] = { fg = M.base_30.blue }, -- tag
    ["@attribute"] = { fg = M.base_30.blue }, -- attribute

    ["@string.escape"] = { fg = "#7c7e86" }, -- string.escape
    ["@string.regex"] = { fg = M.base_30.orange }, -- string.regex

    ["@comment"] = { fg = "#a2a3a7" }, -- comment
    ["@comment.documentation"] = { fg = "#7c7e86" }, -- comment.doc

    ["@markup.link.url"] = { fg = M.base_30.cyan, underline = true }, -- link_uri
  },

  syntax = {
    Constant = { fg = M.base_30.yellow }, -- constant
    Identifier = { fg = M.base_16.base05 }, -- variable
    Label = { fg = M.base_30.blue }, -- label
    Operator = { fg = M.base_30.cyan }, -- operator
    PreProc = { fg = M.base_16.base0E }, -- preproc
    Repeat = { fg = M.base_16.base0E }, -- keyword
    Statement = { fg = M.base_16.base0E }, -- keyword
    StorageClass = { fg = M.base_16.base0E }, -- keyword
    Structure = { fg = M.base_16.base0A }, -- type
    Tag = { fg = M.base_30.blue }, -- tag
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
