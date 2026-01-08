local M = {}
local api = vim.api

local AUGROUP_NAME = "GitBlameVirtualText"

-- Namespace para virtual text
local blame_ns = api.nvim_create_namespace("git_blame_virtual_text")

-- Cache por línea para no llamar a git innecesariamente
local blame_cache = {}

-- Helpers
local function set_highlight(name, opts)
  vim.api.nvim_set_hl(0, name, {
    fg = opts.fg,
    bold = opts.bold or false,
    italic = opts.italic or false,
  })
end

local function fg_of_group(group)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
  if ok and hl.fg then
    return string.format("#%06x", hl.fg)
  end
  return nil
end
local function cache_key(file, line)
  return file .. ":" .. line
end

-- Defaults
M.defaults = {
  enabled = false,

  highlights = {
    author = { fg = fg_of_group("Comment"), bold = true },
    date = { fg = fg_of_group("Identifier"), italic = true },
    msg = { fg = fg_of_group("Normal") },
  },

  popup = {
    max_width = 80,
    max_height = 15,
    border = "rounded",
  },
}
-- Función principal para mostrar blame virtual text
function M.blameVirtText()
  if not M.opts.enabled then
    return
  end

  local ft = vim.fn.expand("%:h:t")
  if ft == "" or ft == "bin" then
    return
  end

  local mode = api.nvim_get_mode().mode
  if mode:match("i") then
    return
  end -- No mostrar en modo insert

  local currFile = vim.fn.expand("%:p")
  local line = api.nvim_win_get_cursor(0)[1]
  local key = cache_key(currFile, line)

  -- Limpiar solo la línea actual
  api.nvim_buf_clear_namespace(0, blame_ns, line - 1, line)

  -- Usar cache si existe
  if blame_cache[key] then
    api.nvim_buf_set_extmark(0, blame_ns, line - 1, 0, {
      virt_text = blame_cache[key],
      virt_text_pos = "eol",
      priority = 100,
    })
    return
  end

  -- Ejecutar git blame
  local blame = vim.fn.systemlist({
    "git",
    "blame",
    "-c",
    "-L",
    string.format("%d,%d", line, line),
    currFile,
  })[1] or ""

  if blame == "" then
    return
  end

  local hash = vim.split(blame, "%s")[1]
  local text

  if hash == "00000000" then
    text = "Not Committed Yet"
  else
    local result = vim.fn.systemlist({
      "git",
      "show",
      hash,
      "--format=%an | %ar | %s",
    })
    text = result[1] or "Not Committed Yet"
    text = vim.split(text, "\n")[1]
    if text:find("fatal") then
      text = "Not Committed Yet"
    end
  end

  local author, date, msg = text:match("^(.-) | (.-) | (.*)$")
  if not author then
    author, date, msg = "?", "?", text
  end

  -- Crear virtual text con colores
  local virt_text = {
    { author .. " ", "GitBlameAuthor" },
    { date .. " ",   "GitBlameDate" },
    { msg,           "GitBlameMsg" },
  }

  -- Guardar en cache
  blame_cache[key] = virt_text

  -- Mostrar virtual text
  api.nvim_buf_set_extmark(0, blame_ns, line - 1, 0, {
    virt_text = virt_text,
    virt_text_pos = "eol",
    priority = 100,
  })
end

-- Función para limpiar virtual text
function M.clearBlameVirtText()
  api.nvim_buf_clear_namespace(0, blame_ns, 0, -1)
end

-- Mostrar cache en ventana flotante
function M.showCachePopup()
  local buf = api.nvim_create_buf(false, true)

  local lines = {}
  for key, virt_text in pairs(blame_cache) do
    local parts = {}
    for _, chunk in ipairs(virt_text) do
      table.insert(parts, chunk[1])
    end
    table.insert(lines, key .. " = " .. table.concat(parts, ""))
  end

  if #lines == 0 then
    lines = { "Cache vacía" }
  end

  local popup = M.opts.popup
  local width = math.min(popup.max_width, vim.o.columns - 4)
  local height = math.min(popup.max_height, #lines)

  local win_opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2 - 1,
    col = (vim.o.columns - width) / 2,
    border = popup.border,
  }

  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  api.nvim_open_win(buf, true, win_opts)

  -- Cerrar con <Esc> o q
  api.nvim_buf_set_keymap(buf, "n", "q", "<Cmd>bd!<CR>", { nowait = true, noremap = true, silent = true })
  api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<Cmd>bd!<CR>", { nowait = true, noremap = true, silent = true })
end

-- Configurar autocomandos
function M.setup_autocmds()
  local group = api.nvim_create_augroup(AUGROUP_NAME, { clear = true })

  api.nvim_create_autocmd("CursorHold", {
    group = group,
    callback = function()
      if vim.api.nvim_get_mode().mode:match("i") then
        return
      end
      M.blameVirtText()
    end,
  })

  api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = group,
    callback = function()
      M.clearBlameVirtText()
    end,
  })
end

-- Toggle
function M.toggleBlame()
  M.opts.enabled = not M.opts.enabled

  if not M.opts.enabled then
    M.clearBlameVirtText()
    pcall(api.nvim_del_augroup_by_name, AUGROUP_NAME)
    vim.notify("Git Blame disabled", vim.log.levels.INFO)
  else
    M.setup_autocmds()
    vim.notify("Git Blame enabled", vim.log.levels.INFO)
  end
end

-- Setup principal
function M.setup(opts)
  opts = opts or {}
  M.opts = vim.tbl_deep_extend("force", {}, M.defaults, opts)

  -- Highlights
  set_highlight("GitBlameAuthor", M.opts.highlights.author)
  set_highlight("GitBlameDate", M.opts.highlights.date)
  set_highlight("GitBlameMsg", M.opts.highlights.msg)

  -- Reaplicar highlights al cambiar colorscheme
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      set_highlight("GitBlameAuthor", M.opts.highlights.author)
      set_highlight("GitBlameDate", M.opts.highlights.date)
      set_highlight("GitBlameMsg", M.opts.highlights.msg)
    end,
  })

  -- Comando toggle
  vim.api.nvim_create_user_command("GitBlameToggle", function()
    M.toggleBlame()
  end, {})

  -- Auto-enable si está configurado
  if M.opts.enabled then
    M.setup_autocmds()
  end
end

return M
