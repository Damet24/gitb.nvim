# GitBlame Virtual Text for Neovim

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg)](https://lua.org)
[![Neovim 0.9+](https://img.shields.io/badge/Neovim-0.9%2B-green.svg)](https://neovim.io)

---

## [English](#english) | [Español](https://github.com/Damet24/gitb.nvim/README.es.md)

---

## English

Displays **Git blame** information as virtual text in Neovim, line by line.
Allows you to customize colors, enable/disable, and show the cache in a floating window.

![screenshot](https://github.com/Damet24/gitb.nvim/screenshots/screenshot_1.png)
![screenshot](https://github.com/Damet24/gitb.nvim/screenshots/screenshot_2.png)
![screenshot](https://github.com/Damet24/gitb.nvim/screenshots/screenshot_3.png)

### Features

- 📊 Git blame visualization on current line using **virtual text**
- 💾 Local cache per line to minimize Git calls
- 🪟 Floating popup with full blame cache
- 🎨 Configurable colors and styles
- 🔄 Auto-applies highlights when changing colorscheme
- ⚡ Easy toggle with command `:GitBlameToggle`
- ⏱️ Lazy loading for fast startup
- 🩺 Health check with `:checkhealth gitb`

### Requirements

- Neovim >= 0.9.0
- Git installed and available in PATH

---

### Installation

With your favorite plugin manager:

**[lazy.nvim]**

```lua
{
  "Damet24/gitb.nvim",
  config = function()
    require("gitb_nvim").setup()
  end
}
```

**[packer.nvim]**

```lua
use {
  "Damet24/gitb.nvim",
  config = function()
    require("gitb_nvim").setup()
  end
}
```

---

### Usage

#### Toggle Blame Command

```vim
:GitBlameToggle
```

#### Show cache in floating window

```lua
require("gitb_nvim").showCachePopup()
```

---

### Configuration

All options are passed through a **single `setup()` object**:

```lua
require("gitb_nvim").setup({
  enabled = true, -- start enabled

  highlights = {
    author = { fg = "#FF0000", bold = true },
    date   = { fg = "#00FF00", italic = true },
    msg    = { fg = "#0000FF" },
  },

  popup = {
    max_width  = 100,      -- maximum width of floating window
    max_height = 20,       -- maximum height of floating window
    border     = "double", -- border style: "rounded", "single", "double", etc.
  },
})
```

#### Configuration Options

| Option              | Type    | Default                                     | Description                                                          |
| ------------------- | ------- | ------------------------------------------- | -------------------------------------------------------------------- |
| `enabled`           | boolean | `false`                                     | Start the plugin enabled                                             |
| `highlights.author` | table   | `{ fg = colors.Comment, bold = true }`      | Color and style of the author                                        |
| `highlights.date`   | table   | `{ fg = colors.Identifier, italic = true }` | Color and style of the date                                          |
| `highlights.msg`    | table   | `{ fg = colors.Normal }`                    | Color of the message                                                 |
| `popup.max_width`   | number  | `80`                                        | Maximum width of the popup                                           |
| `popup.max_height`  | number  | `15`                                        | Maximum height of the popup                                          |
| `popup.border`      | string  | `"rounded"`                                 | Border style (`"rounded"`, `"single"`, `"double"`, `"shadow"`, etc.) |

#### Custom Highlights

You can customize highlights directly: >

vim.api.nvim_set_hl(0, "GitBlameAuthor", { fg = "#FFA500", bold = true })
vim.api.nvim_set_hl(0, "GitBlameDate", { fg = "#00FFFF", italic = true })
vim.api.nvim_set_hl(0, "GitBlameMsg", { fg = "#FFFFFF" })
<

---

### Full Example

```lua
require("gitb_nvim").setup({
  enabled = true,

  highlights = {
    author = { fg = "#FFA500", bold = true },
    date   = { fg = "#00FFFF", italic = true },
    msg    = { fg = "#FFFFFF" },
  },

  popup = {
    max_width  = 80,
    max_height = 15,
    border     = "rounded",
  },
})
```

---
