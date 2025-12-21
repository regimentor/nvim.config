vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
-- Перемещение по сплитам
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")


vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection and keep selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection and keep selection" })

-- Move lines up and down in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })


-- ============================================================================
-- Terminal
-- ============================================================================
-- Exit terminal mode with a shortcut that is easier to discover
-- NOTE: This won't work in all terminal emulators/tmux/etc.
-- Use <C-\><C-n> as fallback to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- Utilities
-- ============================================================================
-- Clear search highlights when pressing <Esc> in normal mode
-- See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
-- ============================================================================
-- fzf plugin
-- ============================================================================
local fzf_lua = require("fzf-lua")
vim.keymap.set('n', '<leader>ff', function()
    fzf_lua.files()
end)
vim.keymap.set('n', '<leader>fg', function()
    fzf_lua.live_grep()
end)
vim.keymap.set('n', '<leader>fb', function()
    fzf_lua.buffers()
end)
-- ============================================================================
-- NvimTree
-- ============================================================================
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Exit terminal mode" })

-- ============================================================================
-- Harpoon
-- ============================================================================
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>t", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
