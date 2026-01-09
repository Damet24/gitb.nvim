local M = {}

function M.check()
  vim.health.start("gitb.nvim")

  local health = vim.health or require("health")
  local ok, log_msg = pcall(health.report_start, "gitb.nvim")

  if not ok then
    vim.cmd("echohl WarningMsg | echom 'gitb.nvim health check' | echohl None")
  end

  local report_ok = health.report_ok or vim.health.ok
  local report_error = health.report_error or vim.health.error
  local report_info = health.report_info or vim.health.info

  if vim.fn.executable("git") == 1 then
    local git_version = vim.fn.system("git --version"):match("git version (.*)")
    if git_version then
      report_ok(string.format("Git found: %s", git_version))
    else
      report_ok("Git found: version unknown")
    end
  else
    report_error("Git not found. Please install git to use gitb.nvim.")
  end

  local ok_config, config = pcall(require, "gitb_nvim.defaults")
  if ok_config then
    report_ok("Configuration loaded successfully")
    if report_info then
      report_info(string.format("Plugin enabled by default: %s", tostring(config.enabled)))
    end
  else
    report_error("Failed to load configuration")
  end

  if report_info then
    report_info("For more information: :h gitb")
  end
end

return M
