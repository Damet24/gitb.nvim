-- Lazy entry point for gitb.nvim
-- Loads main module only when commands are executed

vim.api.nvim_create_user_command("GitBlameToggle", function()
  require("gitb_nvim").toggleBlame()
end, { desc = "Toggle Git Blame virtual text" })

vim.api.nvim_create_user_command("GitBlameShowCache", function()
  require("gitb_nvim").showCachePopup()
end, { desc = "Show Git Blame cache popup" })
