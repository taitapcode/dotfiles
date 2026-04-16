_G.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local core_modules = { "options", "autocmds", "keymaps" }
for _, mod in ipairs(core_modules) do
  local ok, err = pcall(require, "config." .. mod)
  if not ok then
    vim.notify("Error loading config." .. mod .. "\n" .. err, vim.log.levels.ERROR)
  end
end

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
if vim.fn.isdirectory(plugin_dir) == 1 then
  for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
    if file:match("%.lua$") then
      local mod_name = "plugins." .. file:gsub("%.lua$", "")
      local ok, err = pcall(require, mod_name)
      if not ok then
        vim.notify("Error in " .. file .. ":\n" .. err, vim.log.levels.ERROR)
      end
    end
  end
end
