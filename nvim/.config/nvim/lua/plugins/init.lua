-- This file ensures lazy.nvim can find all plugin specs in subdirectories
local M = {}

local function get_plugin_dirs()
  local dirs = {}
  local exclude_dirs = {
    "disabled",
    "_backup",
  }
  
  local handle = vim.loop.fs_scandir(vim.fn.stdpath("config") .. "/lua/plugins")
  if handle then
    local function is_excluded(name)
      for _, excluded in ipairs(exclude_dirs) do
        if name == excluded then
          return true
        end
      end
      return false
    end
    
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      
      if type == "directory" and not is_excluded(name) then
        table.insert(dirs, { import = "plugins." .. name })
      end
    end
  end
  
  return dirs
end

return get_plugin_dirs()
