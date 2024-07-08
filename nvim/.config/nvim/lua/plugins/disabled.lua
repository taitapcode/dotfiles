local function disablePlugins(disabled_list)
  local config = {}
  for _, plugin in ipairs(disabled_list) do
    config[#config + 1] = { plugin, enabled = false }
  end

  return config
end

-- Add plugins you want to disable here
local disabled_plugins = {
  'flash.nvim',
  'persistence.nvim',
  'tokyonight.nvim',
}

return disablePlugins(disabled_plugins)
