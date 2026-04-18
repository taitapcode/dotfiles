vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },
    fish = { 'fish_indent' },
    cpp = {},
  },
  format_on_save = function(bufnr)
    -- Disable with a list of filetypes
    local ignore_filetypes = { 'cpp' }
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    return { timeout_ms = 500, lsp_fallback = true }
  end,
})
