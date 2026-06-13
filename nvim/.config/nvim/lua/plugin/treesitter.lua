vim.pack.add({
  'https://github.com/romus204/tree-sitter-manager.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
})

local ensureInstalled = {
  'lua',
  'python',
  'typescript',
  'json',
  'bash',
  'c',
  'css',
  'diff',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'printf',
  'python',
  'query',
  'regex',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
  'cpp',
  'latex',
}

require('tree-sitter-manager').setup({
  auto_install = true,
  ensure_installed = ensureInstalled,
})

require('nvim-treesitter-textobjects').setup()

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
