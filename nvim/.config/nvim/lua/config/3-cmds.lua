-- Fetch package names for command-line completion
local function complete_packages(arg_lead)
  return vim
    .iter(vim.pack.get())
    :map(function(pack)
      return pack.spec.name
    end)
    :filter(function(name)
      -- Filter results based on current input
      return name:find(arg_lead, 1, true) == 1
    end)
    :totable()
end

-- Update installed packages (use ! to force update)
vim.api.nvim_create_user_command('PackUpdate', function(info)
  if #info.fargs ~= 0 then
    vim.pack.update(info.fargs, { force = info.bang })
  else
    vim.pack.update(nil, { force = info.bang })
  end
end, {
  desc = 'Update packages',
  nargs = '*',
  bang = true,
  complete = complete_packages,
})

-- Remove specified packages from the system
vim.api.nvim_create_user_command('PackDelete', function(info)
  vim.pack.del(info.fargs, { force = info.bang })
end, {
  desc = 'Delete packages',
  nargs = '+',
  bang = true,
  complete = complete_packages,
})

-- Handle accidental Shift-key command typos
local commands = { 'W', 'Wa', 'Wq', 'WQ', 'Q', 'Qa' }
for _, cmd in ipairs(commands) do
  vim.api.nvim_create_user_command(cmd, cmd:lower(), {})
end
