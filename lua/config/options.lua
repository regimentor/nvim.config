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
vim.o.tabstop = 4        -- Tab width in spaces
vim.o.shiftwidth = 4     -- Indent size for >> and <<
vim.o.expandtab = true   -- Convert tabs to spaces
vim.o.smartindent = true -- Smart indentationk
-- Cursorline
vim.opt.cursorline = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }



function _G.WinbarIcon()
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if not ok then
        return ""
    end

    local filename = vim.fn.expand("%:t")
    if filename == "" then
        return ""
    end

    local icon, _ = devicons.get_icon(filename, nil, { default = true })
    return icon or ""
end

vim.o.winbar = "%#WinBar# %{v:lua.WinbarIcon()} %f "
