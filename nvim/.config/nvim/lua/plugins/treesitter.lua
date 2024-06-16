return {
  'nvim-treesitter',
  opts = function(_, opts)
    opts.autotag = { enable = true }

    if type(opts.ensure_installed) == 'table' then
      vim.list_extend(opts.ensure_installed, {
        'css',
        'scss',
      })
    end
  end,
}
