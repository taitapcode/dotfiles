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
  return MiniCompletion.default_process_items(items, base, opts)
end

require('mini.completion').setup({
  lsp_completion = { process_items = process_items },
})

vim.lsp.config('*', {capabilities = MiniCompletion.get_lsp_capabilities()})
