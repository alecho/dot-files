return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  },
  config = function()
    require("nvim-treesitter").install({
      "bash", "css", "dockerfile", "eex", "elixir", "gitignore", "go", "graphql",
      "heex", "html", "javascript", "json", "lua", "markdown", "markdown_inline",
      "ruby", "tsx", "typescript", "vim", "vimdoc", "vue", "yaml",
    })
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
      callback = function(event)
        local language = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
        if not language or not vim.treesitter.language.add(language) then return end
        if language ~= "html" then vim.treesitter.start(event.buf, language) end
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = true },
      move = { set_jumps = true },
    })
    for key, capture in pairs({
      af = "@function.outer", ["if"] = "@function.inner",
      ac = "@class.outer", ic = "@class.inner",
      ["a'"] = "@string.outer", ["i'"] = "@string.inner",
      ai = "@conditional.outer", ii = "@conditional.inner",
      ["a="] = "@assignment.outer", ["i="] = "@assignment.inner",
      ["l="] = "@assignment.lhs", ["r="] = "@assignment.rhs",
      ["a;"] = "@statement.outer", ["i;"] = "@statement.inner",
      ["a,"] = "@parameter.outer", ["i,"] = "@parameter.inner",
      ["a/"] = "@comment.outer", ["i/"] = "@comment.inner",
      al = "@loop.outer", il = "@loop.inner",
      ["a("] = "@call.outer", ["i("] = "@call.inner",
      ["a["] = "@index.outer", ["i["] = "@index.inner",
      ["a{"] = "@block.outer", ["i{"] = "@block.inner",
      ["a<"] = "@template.outer", ["i<"] = "@template.inner",
    }) do
      vim.keymap.set({ "x", "o" }, key, function()
        require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
      end)
    end
    for direction, keys in pairs({
      swap_next = { ["<leader>l,"] = "@parameter.inner", ["<leader>lp"] = "@paragraph.inner" },
      swap_previous = { ["<leader>h,"] = "@parameter.inner", ["<leader>hp"] = "@paragraph.inner" },
    }) do
      for key, capture in pairs(keys) do
        vim.keymap.set("n", key, function()
          require("nvim-treesitter-textobjects.swap")[direction](capture)
        end)
      end
    end
    for direction, keys in pairs({
      goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
    }) do
      for key, capture in pairs(keys) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          require("nvim-treesitter-textobjects.move")[direction](capture, "textobjects")
        end)
      end
    end

    -- Neovim 0.12 provides incremental selection with an/in.
    vim.keymap.set("n", "gv", "van", { remap = true })
    vim.keymap.set("x", "gv", "an", { remap = true })
    vim.keymap.set("x", "gV", "in", { remap = true })
    for _, key in ipairs({ "<leader>df", "<leader>dF" }) do
      vim.keymap.set({ "n", "x" }, key, function()
        vim.lsp.buf_request(0, "textDocument/definition", function(client)
          return vim.lsp.util.make_position_params(0, client.offset_encoding)
        end, function(err, result)
          if err then vim.notify(err.message, vim.log.levels.ERROR); return end
          local location = vim.islist(result) and result[1] or result
          -- ponytail: use the LSP definition range; expand via queries if previews are too narrow.
          if location then vim.lsp.util.preview_location(location, { border = "none" }) end
        end)
      end)
    end
  end,
}
