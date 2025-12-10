---
--- PLUGINS
---
require('plugins.treesitter')
require('plugins.devicons')
require('plugins.tree')
require('plugins.neoscroll')
require('plugins.scroll-bar')
require('plugins.fzf')
require('plugins.conform')
require('plugins.gitsigns')
require('plugins.lualine')
require('plugins.copilot')
require('plugins.smear-cursor')
require('plugins.auto-session')

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
