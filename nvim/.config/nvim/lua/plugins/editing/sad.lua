-- Batch editing
return {
  "ray-x/sad.nvim",
  dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  cmd = "Sad",
  config = function()
    require("sad").setup {}
  end,
}
