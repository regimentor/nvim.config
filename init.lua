vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

---
--- PLUGINS
---
-- Register the binary install hook before vim.pack restores the lockfile.
require('plugins.fff')
require('plugins.snacks')
require('plugins.plenary')
require('plugins.coverage')
require('plugins.treesitter')
require('plugins.devicons')
require('plugins.scroll-bar')
require('plugins.conform')
require('plugins.gitsigns')
require('plugins.diffview')
require('plugins.lualine')
require('plugins.copilot')
require('plugins.blink')
require('plugins.smear-cursor')
require('plugins.harpoon')
-- require('plugins.auto-session')

---
--- CUSTOM PLUGINS
---
require('custom_plugins.winbar')
---
--- CONFIG
---
require('config.options')
require('config.keybinds')
require('config.lsp')
require('config.diagnostic')


---
--- THEMES
---
require('themes.cyberdream')

vim.cmd("colorscheme cyberdream")
