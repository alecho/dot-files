return {
  "yetone/avante.nvim",
  -- Build step is required for this plugin
  build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"
  opts = {
    -- Default configuration options
    -- You can customize your preferred provider here
    -- provider = "claude", -- Uncomment to set a default provider

    -- Example provider configurations
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
    },
  },

  -- Required dependencies
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Optional but recommended dependencies
    "nvim-tree/nvim-web-devicons", -- for icons
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions

    -- File selection provider options (pick one or more)
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "echasnovski/mini.pick",     -- for file_selector provider mini.pick
    -- "ibhagwan/fzf-lua",          -- for file_selector provider fzf

    -- Input provider options (pick one)
    "stevearc/dressing.nvim",    -- for input provider dressing
    -- "folke/snacks.nvim",       -- for input provider snacks

    -- Support for image pasting
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- Required for Windows users
          use_absolute_path = true,
        },
      },
    },

    -- Markdown rendering support
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },

    -- Copilot support (optional)
    -- "zbirenbaum/copilot.lua",  -- for providers='copilot'
  },
}
