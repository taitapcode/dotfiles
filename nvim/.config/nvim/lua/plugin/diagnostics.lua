vim.diagnostic.config({
  -- virtual_text = {
  --   spacing = 4,
  --   prefix = '●', -- Or any icon like '󰅚'
  --   severity = { min = vim.diagnostic.severity.WARN },
  -- },

  virtual_lines = { current_line = true },
  underline = true,
  signs = true,
  update_in_insert = true, -- Set to true if you want live feedback as you type
  severity_sort = true,
})
