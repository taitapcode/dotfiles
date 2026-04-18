_G.later = function(callback)
  vim.api.nvim_create_autocmd('VimEnter', {
    once = true, -- Ensures this only happens exactly once at startup
    callback = function()
      -- We wrap it in vim.schedule so it doesn't block the UI from drawing
      vim.schedule(callback)
    end,
  })
end

_G.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end
