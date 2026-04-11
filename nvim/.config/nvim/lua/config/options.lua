-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.laststatus = 3
-- vim.g.lazyvim_picker = 'snacks'
vim.g.lazyvim_picker = 'fzf'
vim.g.ai_cmp = false

-- Custom clipboard provider to suppress wl-paste errors when empty
vim.g.clipboard = {
  name = 'WlClipboardFix',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy --primary',
  },
  paste = {
    ['+'] = function()
      -- Redirect stderr to /dev/null to hide the "Nothing is copied" error
      local result = vim.fn.systemlist('wl-paste --no-newline 2>/dev/null')
      if vim.v.shell_error ~= 0 then
        return { '' }
      end
      return result
    end,
    ['*'] = function()
      local result = vim.fn.systemlist('wl-paste --primary --no-newline 2>/dev/null')
      if vim.v.shell_error ~= 0 then
        return { '' }
      end
      return result
    end,
  },
  cache_enabled = 1,
}
