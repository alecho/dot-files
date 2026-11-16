-- Run: nvim --headless -u NONE -l ~/.config/nvim/tests/pi-prompts.lua
local config = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.runtimepath:prepend(config)
vim.cmd("filetype plugin on")
vim.api.nvim_create_autocmd("FileType", {
  callback = function() vim.wo.colorcolumn = "81" end,
})
dofile(config .. "/after/plugin/pi-prompts.lua")

local dir = vim.fn.tempname()
vim.fn.mkdir(dir .. "/pi-editor-test", "p")
local prompt = dir .. "/pi-editor-test/prompt.md"
local markdown = dir .. "/prompt.md"
vim.fn.writefile({}, prompt)
vim.fn.writefile({}, markdown)

local ok, err = pcall(function()
  vim.cmd.edit(markdown)
  assert(vim.bo.textwidth == 80)
  assert(vim.wo.colorcolumn == "81")
  local markdown_buffer = vim.api.nvim_get_current_buf()
  local original_maps = { j = vim.fn.maparg("j", "n"), k = vim.fn.maparg("k", "n") }

  vim.cmd.edit(prompt)
  assert(vim.bo.filetype == "markdown")
  assert(vim.bo.textwidth == 0 and vim.bo.wrapmargin == 0)
  assert(not vim.bo.formatoptions:find("[tca]"))
  assert(vim.wo.colorcolumn == "")
  assert(vim.wo.wrap and vim.wo.linebreak and vim.wo.spell)
  for _, key in ipairs({ "j", "k" }) do
    local mapping = vim.fn.maparg(key, "n", false, true)
    assert(mapping.buffer == 1 and mapping.expr == 1)
    assert(mapping.rhs == "v:count == 0 ? 'g" .. key .. "' : '" .. key .. "'")
  end
  local prose = string.rep("long prompt text ", 20)
  vim.cmd.normal({ "i" .. prose, bang = true })
  vim.cmd.write()
  assert(vim.deep_equal(vim.fn.readfile(prompt), { prose }))

  vim.cmd.buffer(markdown_buffer)
  assert(vim.bo.textwidth == 80 and vim.wo.colorcolumn == "81")
  assert(vim.fn.maparg("j", "n") == original_maps.j and vim.fn.maparg("k", "n") == original_maps.k)
end)
vim.fn.delete(dir, "rf")
assert(ok, err)
print("pi prompt settings: OK; ordinary Markdown unchanged")
