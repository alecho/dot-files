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
  {
    "BufRead,BufNewFile",
    "*.prompt",
    "setlocal wrap",
    "setlocal wrapmargin=80",
    "setlocal syntax=off",
  },
  -- Default to 80 character limit
  { "FileType", "*", "setlocal colorcolumn=81" },

  -- Markdown 80 character limit, conceal, spellchecking
  {
    "FileType",
    "*.md",
    "setlocal textwidth=80",
    "setlocal conceallevel=2",
    "setlocal spell",
  },

  -- Git commit messages: spell checking and 51 character limit
  {
    "FileType",
    "gitcommit",
    "setlocal spell",
    "setlocal colorcolumn=51",
  },

  -- Startup screen
  {
    "FileType",
    "alpha",
    "setlocal colorcolumn=0",
    "setlocal laststatus=0",
  },
}

-- Register autocmds
for _, cmd_group in pairs(autocmds) do
  for i = 3, #cmd_group do
    vim.api.nvim_create_autocmd({ cmd_group[1] }, {
      pattern = cmd_group[2],
      command = cmd_group[i],
    })
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
