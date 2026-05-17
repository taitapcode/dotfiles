vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = {
    enabled = true,
    b = { completion = false },
  },
  picker = {
    enabled = true,
    -- layout = "ivy",
    sources = {
      files = { hidden = true },
    },
    win = {
      input = {
        keys = {
          ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          ['<C-o>'] = { 'confirm', mode = { 'n', 'i' } },
        },
      },
    },
  },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_picker_input',
  callback = function()
    -- Disable mini.completion for this specific buffer
    vim.b.minicompletion_disable = true

    -- Prevent Neovim 0.12 nightly's native autocomplete from triggering (if enabled)
    vim.opt_local.autocomplete = false
  end,
})

-- Delete Buffer
map('n', '<m-w>', function()
  Snacks.bufdelete()
end, { desc = 'Delete Buffer' })

-- Files Picker
map('n', '<leader><space>', function()
  Snacks.picker.files({ layout = { preset = 'ivy' } })
end, { desc = 'Find Files' })
map('n', '<leader>,', function()
  Snacks.picker.buffers({ layout = { preset = 'ivy' } })
end, { desc = 'Buffers' })
map('n', '<leader>/', function()
  Snacks.picker.grep({ layout = { preset = 'ivy' } })
end, { desc = 'Grep' })
map('n', '<leader>:', function()
  Snacks.picker.command_history()
end, { desc = 'Command History' })
map('n', '<leader>n', function()
  Snacks.picker.notifications()
end, { desc = 'Notification History' })

-- Find
map('n', '<leader>fb', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })
map('n', '<leader>fg', function()
  Snacks.picker.git_files()
end, { desc = 'Find Git Files' })
map('n', '<leader>fp', function()
  Snacks.picker.projects()
end, { desc = 'Projects' })
map('n', '<leader>fr', function()
  Snacks.picker.recent()
end, { desc = 'Recent' })

-- Git
map('n', '<leader>gb', function()
  Snacks.picker.git_branches()
end, { desc = 'Git Branches' })
map('n', '<leader>gl', function()
  Snacks.picker.git_log()
end, { desc = 'Git Log' })
map('n', '<leader>gL', function()
  Snacks.picker.git_log_line()
end, { desc = 'Git Log Line' })
map('n', '<leader>gs', function()
  Snacks.picker.git_status()
end, { desc = 'Git Status' })
map('n', '<leader>gS', function()
  Snacks.picker.git_stash()
end, { desc = 'Git Stash' })
map('n', '<leader>gd', function()
  Snacks.picker.git_diff()
end, { desc = 'Git Diff (Hunks)' })
map('n', '<leader>gf', function()
  Snacks.picker.git_log_file()
end, { desc = 'Git Log File' })
map('n', '<leader>gg', function()
  Snacks.lazygit()
end, { desc = 'Open lazygit' })

-- Grep & Search
map('n', '<leader>sb', function()
  Snacks.picker.lines()
end, { desc = 'Buffer Lines' })
map('n', '<leader>sB', function()
  Snacks.picker.grep_buffers({ layout = { preset = 'ivy' } })
end, { desc = 'Grep Open Buffers' })
map('n', '<leader>sg', function()
  Snacks.picker.grep({ layout = { preset = 'ivy' } })
end, { desc = 'Grep' })
map({ 'n', 'x' }, '<leader>sw', function()
  Snacks.picker.grep_word({ layout = { preset = 'ivy' } })
end, { desc = 'Visual selection or word' })
map('n', '<leader>s"', function()
  Snacks.picker.registers({ layout = { preset = 'ivy' } })
end, { desc = 'Registers' })
map('n', '<leader>s/', function()
  Snacks.picker.search_history({ layout = { preset = 'ivy' } })
end, { desc = 'Search History' })
map('n', '<leader>sa', function()
  Snacks.picker.autocmds()
end, { desc = 'Autocmds' })
map('n', '<leader>sc', function()
  Snacks.picker.command_history()
end, { desc = 'Command History' })
map('n', '<leader>sC', function()
  Snacks.picker.commands()
end, { desc = 'Commands' })
map('n', '<leader>sh', function()
  Snacks.picker.help({ layout = { preset = 'ivy' } })
end, { desc = 'Help Pages' })
map('n', '<leader>si', function()
  Snacks.picker.icons()
end, { desc = 'Icons' })
map('n', '<leader>sj', function()
  Snacks.picker.jumps()
end, { desc = 'Jumps' })
map('n', '<leader>sk', function()
  Snacks.picker.keymaps({ layout = { preset = 'vscode' } })
end, { desc = 'Keymaps' })
map('n', '<leader>sl', function()
  Snacks.picker.loclist()
end, { desc = 'Location List' })
map('n', '<leader>sm', function()
  Snacks.picker.marks()
end, { desc = 'Marks' })
map('n', '<leader>sM', function()
  Snacks.picker.man()
end, { desc = 'Man Pages' })
map('n', '<leader>sq', function()
  Snacks.picker.qflist()
end, { desc = 'Quickfix List' })
map('n', '<leader>sR', function()
  Snacks.picker.resume()
end, { desc = 'Resume' })
map('n', '<leader>su', function()
  Snacks.picker.undo()
end, { desc = 'Undo History' })
map('n', '<leader>ss', function()
  Snacks.picker.lsp_symbols({ layout = { preset = 'right' } })
end, { desc = 'LSP Symbols (Outline)' })
map('n', '<leader>sS', function()
  Snacks.picker.lsp_workspace_symbols({ layout = { preset = 'right' } })
end, { desc = 'LSP Workspace Symbols' })
