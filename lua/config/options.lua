---
--- GLOBALS
---
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true



---
--- OPTIONS
---
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.confirm = true
-- Tab settings
vim.opt.tabstop = 4        -- Tab width in spaces
vim.opt.shiftwidth = 4     -- Indent size for >> and <<
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart indentationk
-- Cursorline
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function()
        vim.wo.cursorline = true
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        vim.wo.cursorline = false
    end,
})
