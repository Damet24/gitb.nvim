# GitBlame Virtual Text for Neovim

Muestra información de **Git blame** como virtual text en Neovim, línea por línea.
Permite personalizar colores, habilitar/deshabilitar, y mostrar la cache en una ventana flotante.

---

## Instalación

Con tu gestor de plugins favorito:

**[lazy.nvim]**

```lua
{
  "Damet24/gitb.nvim",
  config = function()
    require("gitb.nvim").setup()
  end
}
```

**[packer.nvim]**

```lua
use {
  "Damet24/gitb.nvim",
  config = function()
    require("gitb.nvim").setup()
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
require("gitb.nvim").showCachePopup()
```

---

## Configuración

Todas las opciones se pasan a través de un **único objeto `setup()`**:

```lua
require("gitb.nvim").setup({
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

#### Explicación de opciones

- `enabled` – boolean, si iniciar el plugin activado o no.
- `highlights` – colores y estilos para cada parte del blame:
  - `author` – color y opcional `bold`
  - `date` – color y opcional `italic`
  - `msg` – color del mensaje

- `popup` – configuración de la ventana flotante que muestra la cache:
  - `max_width` – ancho máximo
  - `max_height` – alto máximo
  - `border` – estilo de borde (`"rounded"`, `"single"`, `"double"`, etc.)

---

## Ejemplo completo

```lua
require("gitb.nvim").setup({
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
