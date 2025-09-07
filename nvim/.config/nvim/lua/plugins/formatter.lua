return {
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft.java = { 'clang-format' }
      opts.formatters_by_ft.cpp = { 'clang-format' }
      opts.formatters_by_ft.c = { 'clang-format' }
    end,
  },
  {
    'mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'clang-format',
        })
      end
    end,
  },
}
