vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
-- Перемещение по сплитам
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set("n", "<leader>n", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>p", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection and keep selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection and keep selection" })

-- Move lines up and down in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
-- macOS terminals often send literal characters (Option+j/k -> ∆/˚) instead of <A-j>/<A-k>
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", { desc = "Move selection down (macOS)", silent = true })
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", { desc = "Move selection up (macOS)", silent = true })


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
-- Search
-- ============================================================================
vim.keymap.set('n', '<leader>ff', function()
    require('fff').find_files()
end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function()
    require('fff').live_grep()
end, { desc = 'Find text' })
vim.keymap.set('n', '<leader>fb', function()
    Snacks.picker.buffers()
end, { desc = 'Find buffers' })

-- ============================================================================
-- Git
-- ============================================================================
local gitsigns = require('gitsigns')
local function git_map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
end

git_map('n', '<leader>hj', function()
    gitsigns.nav_hunk('next')
end, 'Git: next hunk')
git_map('n', '<leader>hk', function()
    gitsigns.nav_hunk('prev')
end, 'Git: previous hunk')
git_map('n', '<leader>hp', gitsigns.preview_hunk, 'Git: preview hunk')
git_map('n', '<leader>hi', gitsigns.preview_hunk_inline, 'Git: preview hunk inline')
git_map('n', '<leader>hs', gitsigns.stage_hunk, 'Git: stage hunk')
git_map('n', '<leader>hr', gitsigns.reset_hunk, 'Git: reset hunk')
git_map('v', '<leader>hs', function()
    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, 'Git: stage selected lines')
git_map('v', '<leader>hr', function()
    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, 'Git: reset selected lines')
git_map('n', '<leader>hS', gitsigns.stage_buffer, 'Git: stage buffer')
git_map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Git: undo stage hunk')
git_map('n', '<leader>hb', gitsigns.blame_line, 'Git: blame line')
git_map('n', '<leader>hd', '<cmd>DiffviewOpen<CR>', 'Git: open inline diff view')
git_map('n', '<leader>hf', '<cmd>DiffviewFileHistory %<CR>', 'Git: current file history')
git_map('n', '<leader>hH', '<cmd>DiffviewFileHistory<CR>', 'Git: repository history')
git_map('n', '<leader>hq', '<cmd>DiffviewClose<CR>', 'Git: close diff view')

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

for index = 1, 4 do
    vim.keymap.set("n", "<leader>" .. index, function()
        harpoon:list():select(index)
    end, { desc = "Harpoon: select file " .. index, silent = true })
end

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
