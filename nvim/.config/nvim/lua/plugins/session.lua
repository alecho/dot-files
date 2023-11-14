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
  end
}
