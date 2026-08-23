return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    init = function()
      vim.api.nvim_create_user_command("CopyFileName", function()
        local filename = vim.fn.expand("%:t")
        vim.fn.setreg("+", filename)
        vim.notify("Copied: " .. filename)
      end, {})

      vim.api.nvim_create_user_command("CopyFilePath", function()
        local path = vim.fn.expand("%:p")
        vim.fn.setreg("+", path)
        vim.notify("Copied: " .. path)
      end, {})

      vim.keymap.set("n", "<leader>yf", "<cmd>CopyFileName<cr>", {
        desc = "Copy current file name",
      })

      vim.keymap.set("n", "<leader>yp", "<cmd>CopyFilePath<cr>", {
        desc = "Copy current file path",
      })
    end,
  },
}
