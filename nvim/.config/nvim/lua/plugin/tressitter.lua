vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter', 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' })

local ensureInstalled = {
  'lua', 'python', 'typescript',     "bash",
    "c",
    "diff",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "printf",
    "python",
    "query",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "cpp"

}
local alreadyInstalled = require('nvim-treesitter.config').get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
  :filter(function(parser)
    return not vim.tbl_contains(alreadyInstalled, parser)
  end)
  :totable()
require('nvim-treesitter').install(parsersToInstall)

require('nvim-treesitter-textobjects').setup()
require('nvim-treesitter').setup({
  autotag = { enable = true },
  folds = { enable = true },
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(e)
    local name, kind = e.data.spec.name, e.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not e.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    -- Enable treesitter highlighting and disable regex syntax
    pcall(vim.treesitter.start)
    -- Enable treesitter-based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
