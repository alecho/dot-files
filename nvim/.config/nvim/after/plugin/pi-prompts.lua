-- Keep pi's temporary prompts as Markdown, but do not hard-wrap prose.
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("PiPrompts", { clear = true }),
  pattern = "*/pi-editor-*/prompt.md",
  callback = function(event)
    vim.bo[event.buf].textwidth = 0
    vim.bo[event.buf].wrapmargin = 0
    vim.opt_local.formatoptions:remove({ "t", "c", "a" })
    vim.wo.colorcolumn = ""
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.spell = true
    for _, key in ipairs({ "j", "k" }) do
      vim.keymap.set("n", key, "v:count == 0 ? 'g" .. key .. "' : '" .. key .. "'", {
        buffer = event.buf,
        expr = true,
        silent = true,
      })
    end
  end,
})
