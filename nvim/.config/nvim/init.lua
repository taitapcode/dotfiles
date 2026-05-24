local config_root = vim.fn.stdpath('config')

local function load_dir(path)
  local target_dir = config_root .. '/lua/' .. path
  local module_prefix = path:gsub('/', '.') .. '.'

  if vim.fn.isdirectory(target_dir) == 1 then
    for _, file in ipairs(vim.fn.readdir(target_dir)) do
      if file:match('%.lua$') then
        local mod_name = module_prefix .. file:gsub('%.lua$', '')
        local ok, err = pcall(require, mod_name)
        if not ok then
          vim.notify('Error loading ' .. mod_name .. ':\n' .. err, vim.log.levels.ERROR)
        end
      end
    end
  end
end

load_dir('config/helper')
load_dir('config')
load_dir('plugin')
