local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
  },
  ui = {
    border = "rounded",
  },
})

vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- Set colorscheme
vim.cmd('colorscheme dracula')

-- Autocmd settings
local autocmds = {
  --
  -- filetypes related autocommands
  {
    events = { "BufRead", "BufNewFile" },
    glob = "*.prompt",
    commands = { 'setlocal wrap', 'setlocal wrapmargin=80', 'setlocal syntax=off' },
  },
  {
    events = { "FileType" },
    glob = "*",
    commands = { "setlocal colorcolumn=81" },
  },
}

-- Register autocmds
for _, group in pairs(autocmds) do
  for _, cmd in pairs(group.commands) do
    vim.api.nvim_exec('augroup MyAutocmds', true)
    vim.api.nvim_exec('autocmd! *', true)

    for _, event in pairs(group.events) do -- allow multiple events with same settings
      vim.api.nvim_exec('autocmd ' .. event .. ' ' .. group.glob .. ' ' .. cmd, true)
    end

    vim.api.nvim_exec('augroup END', true)
  end
end

-- Persisted Hooks
local group = vim.api.nvim_create_augroup("PersistedHooks", {})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedLoadPre",
  group = group,
  callback = function(session)
    vim.notify("Session loaded: " .. session.data)
  end,
})

local actions = require('telescope.actions')
local function switch_branch()
  vim.cmd('SessionSave')
  vim.cmd('BufferCloseAllButPinned')
  require('telescope.builtin').git_branches({
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<CR>', function()
        local selection = require('telescope.actions.state').get_selected_entry()
        if selection then
          -- If branch exists, checkout.
          vim.cmd('!git checkout ' .. selection.value)
        else
          -- If branch does not exist, create and checkout.
          local new_branch = vim.fn.input('Enter new branch name: ',
            require('telescope.actions.state').get_current_line())

          if new_branch ~= "" then
            vim.cmd('!git checkout -b ' .. new_branch)
          end
        end
        -- Close telescope
        actions.close(prompt_bufnr)
        vim.cmd('SessionLoad')
      end)
      return true
    end,
  })
end

-- convert Lua function to Vimscript function
_G.switch_branch = switch_branch

-- define vim command that calls the Lua function
vim.cmd("command! SwitchBranch lua switch_branch()")
