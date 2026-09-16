local M = {}

function M.toggle_nvimtree()
  local api = require "nvim-tree.api"
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.tree.focus()
  end
end

--- Copies "path:line" for the cursor line, or "path:first-last" for a visual
--- selection, to the system clipboard. The path is relative to the working
--- directory.
function M.copy_code_reference()
  local path = vim.fn.expand "%:."

  if path == "" then
    vim.notify("No file to reference in this buffer", vim.log.levels.WARN)
    return
  end

  local first, last = vim.fn.line ".", vim.fn.line "."

  if vim.fn.mode():find "[vV\22]" then
    first, last = vim.fn.line "v", vim.fn.line "."

    if first > last then
      first, last = last, first
    end
  end

  local reference = first == last and path .. ":" .. first or path .. ":" .. first .. "-" .. last

  vim.fn.setreg("+", reference)
  vim.notify(reference)
end

return M
