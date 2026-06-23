-- Handle accidental Shift-key command typos
local commands = { 'W', 'Wa', 'Wq', 'WQ', 'Q', 'Qa' }
for _, cmd in ipairs(commands) do
  vim.api.nvim_create_user_command(cmd, cmd:lower(), {})
end
