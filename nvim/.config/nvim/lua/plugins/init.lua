-- This file ensures lazy.nvim can find all plugin specs in subdirectories
return {
  -- Import all subdirectories
  { import = "plugins.ui" },
  { import = "plugins.lsp" },
  { import = "plugins.treesitter" },
  { import = "plugins.git" },
  { import = "plugins.file_explorer" },
  { import = "plugins.navigation" },
  { import = "plugins.utility" },
  { import = "plugins.completion" },
  { import = "plugins.markdown" },
  { import = "plugins.notifications" },
  { import = "plugins.session" },
  { import = "plugins.browser" },
  { import = "plugins.fun" },
  { import = "plugins.notes" },
  { import = "plugins.editing" },
  { import = "plugins.search" },
}
