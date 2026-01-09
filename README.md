# GitBlame Virtual Text for Neovim

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg)](https://lua.org)
[![Neovim 0.9+](https://img.shields.io/badge/Neovim-0.9%2B-green.svg)](https://neovim.io)

Muestra información de **Git blame** como virtual text en Neovim, línea por línea.
Permite personalizar colores, habilitar/deshabilitar, y mostrar la cache en una ventana flotante.

![screenshot](https://github.com/Damet24/gitb.nvim/raw/master/screenshot.png)

## Features

- 📊 Visualización de Git blame en la línea actual usando **virtual text**
- 💾 Cache local por línea para minimizar llamadas a Git
- 🪟 Popup flotante con toda la cache de blame
- 🎨 Colores y estilos configurables
- 🔄 Auto-aplica highlights al cambiar colorscheme
- ⚡ Toggle fácil con comando `:GitBlameToggle`
- ⏱️ Lazy loading para startup rápido
- 🩺 Health check con `:checkhealth gitb`

## Requirements

- Neovim >= 0.9.0
- Git instalado y disponible en PATH

---

## Instalación

Con tu gestor de plugins favorito:

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

## Uso

### Comando para alternar Blame

```vim
:GitBlameToggle
```

### Mostrar cache en ventana flotante

```lua
require("gitb_nvim").showCachePopup()
```

---

## Configuración

Todas las opciones se pasan a través de un **único objeto `setup()`**:

```lua
require("gitb_nvim").setup({
  enabled = true, -- iniciar activado

  highlights = {
    author = { fg = "#FF0000", bold = true },
    date   = { fg = "#00FF00", italic = true },
    msg    = { fg = "#0000FF" },
  },

  popup = {
    max_width  = 100,      -- ancho máximo de la ventana flotante
    max_height = 20,       -- alto máximo de la ventana flotante
    border     = "double", -- estilo del borde: "rounded", "single", "double", etc.
  },
})
```

### Opciones de configuración

| Opción              | Tipo    | Default                                     | Descripción                                                              |
| ------------------- | ------- | ------------------------------------------- | ------------------------------------------------------------------------ |
| `enabled`           | boolean | `false`                                     | Iniciar el plugin activado                                               |
| `highlights.author` | table   | `{ fg = colors.Comment, bold = true }`      | Color y estilo del autor                                                 |
| `highlights.date`   | table   | `{ fg = colors.Identifier, italic = true }` | Color y estilo de la fecha                                               |
| `highlights.msg`    | table   | `{ fg = colors.Normal }`                    | Color del mensaje                                                        |
| `popup.max_width`   | number  | `80`                                        | Ancho máximo del popup                                                   |
| `popup.max_height`  | number  | `15`                                        | Alto máximo del popup                                                    |
| `popup.border`      | string  | `"rounded"`                                 | Estilo del borde (`"rounded"`, `"single"`, `"double"`, `"shadow"`, etc.) |

### Highlights personalizados

Puedes personalizar los highlights directamente: >

vim.api.nvim_set_hl(0, "GitBlameAuthor", { fg = "#FFA500", bold = true })
vim.api.nvim_set_hl(0, "GitBlameDate", { fg = "#00FFFF", italic = true })
vim.api.nvim_set_hl(0, "GitBlameMsg", { fg = "#FFFFFF" })
<

---

## Ejemplo completo

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

## Características

- Visualización de Git blame en la línea actual usando **virtual text**.
- Cache local por línea para minimizar llamadas a Git.
- Popup flotante con toda la cache de blame.
- Colores y estilos configurables.
- Auto-aplica highlights al cambiar colorscheme.
- Toggle fácil con comando `:GitBlameToggle`.

---
