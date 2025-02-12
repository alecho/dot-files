return {
  "olimorris/persisted.nvim",
  lazy = false,
  priority = 900,
  cond = not vim.g.started_by_firenvim,
  config = function()
    vim.o.sessionoptions = "buffers,curdir,globals,tabpages,winpos,winsize"
    local project_dir = vim.fn.getcwd()

    require("persisted").setup({
      save_dir = project_dir .. "/.sessions", -- Store sessions in a .sessions directory in the project
      use_git_branch = true,
      should_save = function()
        -- Do not save if the alpha dashboard is the current filetype
        if vim.bo.filetype == "alpha" then
          return false
        end
        return true
      end,
      ignored_dirs = {
        "/private",
        "~/Downloads",
      },
    })
    require("telescope").load_extension("persisted")

    local group = vim.api.nvim_create_augroup("PersistedHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedSavePost",
      group = group,
      callback = function()
        vim.notify("Session saved: " .. require("persisted").last())
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedLoadPost",
      group = group,
      callback = function()
        vim.notify("Session loaded for branch: " .. require("persisted").branch())
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedTelescopeLoadPre",
      group = group,
      callback = function()
        require("persisted").save({ session = vim.g.persisted_loaded_session })
        vim.api.nvim_input("<ESC>:BufferCloseAllButPinned<CR>")
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedTelescopeLoadPost",
      group = group,
      callback = function()
        local persisted = require("persisted")
        -- checkout the branch in git
        if persisted.branch() then
          vim.notify("Checking out branch: " .. persisted.branch())
          vim.api.nvim_input("<ESC>:!git checkout --quiet " .. persisted.branch() .. "<CR>")
        end
      end,
    })
  end
}
