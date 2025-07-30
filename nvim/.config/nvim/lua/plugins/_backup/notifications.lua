return {
  "rcarriga/nvim-notify",
  event = "VimEnter",
  config = function()
    local banned_messages = {
      "[LSP] Format request failed, no matching language servers.",
    }

    vim.notify = function(msg, ...)
      for _, banned in ipairs(banned_messages) do
        if msg == banned then
          return
        end
      end
      require("notify")(msg, ...)
    end
  end,
}
