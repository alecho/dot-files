return {
  "olimorris/persisted.nvim",
  lazy = false,
  priority = 900,
  cond = not vim.g.started_by_firenvim,
  config = function()
    require("persisted").setup({
      autoload = true,
      on_autoload_no_session = function()
        vim.notify("No existing session to load.")
      end,
      use_git_branch = true,
      ignored_dirs = {
        "/private",
        "~/Downloads",
      },
    })
    require("telescope").load_extension("persisted")

    local group = vim.api.nvim_create_augroup("PersistedHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedLoadPre",
      group = group,
      callback = function(session)
        vim.notify("Session loaded: " .. session.data.name)
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedTelescopeLoadPre",
      group = group,
      callback = function()
        -- Save the currently loaded session using a global variable

        require("persisted").save({ session = vim.g.persisted_loaded_session })
        vim.api.nvim_input("<ESC>:BufferCloseAllButPinned<CR>")
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedTelescopeLoadPost",
      group = group,
      callback = function(session)
        -- checkout the branch in git
        if session.data.branch then
          vim.notify("Checking out branch: " .. session.data.branch)
          vim.api.nvim_input("<ESC>:!git checkout " .. session.data.branch .. "<CR>")
        end
      end,
    })
  end
}
