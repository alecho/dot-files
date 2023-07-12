return {
  "eandrju/cellular-automaton.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>1", "<Cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it Rain" },
    { "<leader>2", "<Cmd>CellularAutomaton game_of_life<CR>", desc = "Conway's Game of Life" },
  },
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = {
      theme = "summer",
    }
  },
}
