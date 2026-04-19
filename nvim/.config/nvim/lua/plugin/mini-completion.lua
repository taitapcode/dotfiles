vim.pack.add({
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-mini/mini.snippets',
})

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first
    -- gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})
MiniSnippets.start_lsp_server({ match = false })

local kind_priority = { Text = -1, Snippet = 99 }
local opts = { filtersort = 'fuzzy', kind_priority = kind_priority }
local process_items = function(items, base)
  items = MiniCompletion.default_process_items(items, base, opts)
  -- clangd include completion can insert a trailing `"` / `>`.
  -- If we already have `#include ""` / `#include <>` and cursor is inside,
  -- this would lead to `""` / `>>`. Strip only in this narrow context.
  local ft = vim.bo.filetype
  local is_c_family = (ft == 'c' or ft == 'cpp' or ft == 'objc' or ft == 'objcpp' or ft == 'cuda')
  if not is_c_family then
    return items
  end
  local line = vim.api.nvim_get_current_line()
  if not line:match('^%s*#%s*include%s*[%"<]') then
    return items
  end
  -- `col('.')` is 1-based. In insert mode this points at the next character.
  local col = vim.fn.col('.')
  local closer = line:sub(col, col)
  if closer ~= '"' and closer ~= '>' then
    return items
  end
  for _, item in ipairs(items) do
    if type(item.textEdit) == 'table' and type(item.textEdit.newText) == 'string' then
      local s = item.textEdit.newText
      if s:sub(-1) == closer then
        item.textEdit.newText = s:sub(1, -2)
      end
    elseif type(item.insertText) == 'string' then
      local s = item.insertText
      if s:sub(-1) == closer then
        item.insertText = s:sub(1, -2)
      end
    end
  end
  return items
end

require('mini.completion').setup({
  lsp_completion = { process_items = process_items },
})

vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
