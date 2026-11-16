-- Run: nvim --headless -i NONE --cmd 'lua vim.deprecate=function(name) error("Deprecated: "..name) end' \
--   '+lua dofile(vim.fn.expand("~/.config/nvim/tests/startup.lua"))' '+qa!'
local ok, err = xpcall(function()
  require("persisted").stop() -- Do not overwrite the user's saved session during tests.
  dofile(vim.fn.stdpath("config") .. "/tests/pi-prompts.lua")
  require("lazy").load({ plugins = { "nvim-cmp" } })
  assert(not require("lazy.core.config").plugins["codeium.nvim"])
  for _, source in ipairs(require("cmp").get_config().sources) do assert(source.name ~= "codeium") end
  for _, language in ipairs(require("nvim-treesitter").get_installed("parsers")) do
    assert(vim.treesitter.language.add(language))
    vim.treesitter.query.get(language, "highlights")
  end

  vim.cmd.enew()
  local lines = { "local function add(first, second)", "  return first + second", "end", "", "local function other() end" }
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.filetype = "lua"
  assert(vim.treesitter.get_parser(0):parse()[1])
  assert(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()])
  assert(vim.bo.indentexpr == "v:lua.require'nvim-treesitter'.indentexpr()")
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  vim.fn.maparg("]m", "n", false, true).callback()
  assert(vim.api.nvim_win_get_cursor(0)[1] == 5)
  vim.api.nvim_win_set_cursor(0, { 1, lines[1]:find("first", 1, true) - 1 })
  vim.fn.maparg(" l,", "n", false, true).callback()
  vim.api.nvim_feedkeys("", "x", false)
  assert(vim.api.nvim_get_current_line() == "local function add(second, first)")
  assert(vim.fn.maparg("gv", "x") == "an" and vim.fn.maparg("gV", "x") == "in")
  vim.cmd.normal({ '"ayy', bang = true }) -- Exercise yank highlighting.
  local ns = vim.api.nvim_create_namespace("StartupTestDiagnostics")
  vim.diagnostic.set(ns, 0, { { lnum = 1, col = 0, message = "test", severity = vim.diagnostic.severity.ERROR } })
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  vim.api.nvim_feedkeys(vim.keycode("]e"), "xt", false)
  assert(vim.api.nvim_win_get_cursor(0)[1] == 2)
  vim.diagnostic.reset(ns)
  vim.bo.modified = false
  vim.wait(100)
  local messages = vim.api.nvim_exec2("messages", { output = true }).output
  assert(not messages:find("Failed to run", 1, true) and not messages:find("Deprecated:", 1, true), messages)
  vim.cmd.checkhealth("vim.deprecated")
  local health = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  assert(not health:find("WARNING", 1, true), health)
end, debug.traceback)
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd.cquit()
end
print("PASS: full config, Treesitter, textobjects, diagnostics, Codeium removal, and deprecation health")
