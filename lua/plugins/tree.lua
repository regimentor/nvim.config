vim.pack.add({
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' }
})


require("nvim-tree").setup({
    hijack_cursor = true,
    -- sync_root_with_cwd = true,
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        indent_width = 1,
        icons = {
            git_placement = "after",
            bookmarks_placement = "after",
            glyphs = {
                git = {
                    -- unstaged = "×",
                    -- staged = "",
                    -- unmerged = "󰧾",
                    -- untracked = "",
                    renamed = "",
                    deleted = "",
                    -- ignored = "∅"
                    -- deleted = "✖",
                    -- renamed = "→",
                    untracked = "",
                    ignored = "·",
                    unstaged = "",
                    staged = "✓",
                }
            }
        }
    },
    filters = {
        -- dotfiles = true,

    },
})
-- require("nvim-tree").setup {
--     view = {
--         signcolumn = "yes",
--         float = {
--             enable = true,
--             open_win_config = open_win_config_func
--         },
--         cursorline = false
--     },
--     modified = {
--         enable = true
--     },
--     renderer = {
--         indent_width = 3,
--         icons = {
--             show = {
--                 hidden = true
--             },
--             git_placement = "after",
--             bookmarks_placement = "after",
--             symlink_arrow = " -> ",
--             glyphs = {
--                 folder = {
--                     arrow_closed = " ",
--                     arrow_open = " ",
--                     default = "",
--                     open = "",
--                     empty = "",
--                     empty_open = "",
--                     symlink = "",
--                     symlink_open = ""
--                 },
--                 default = "󱓻",
--                 symlink = "󱓻",
--                 bookmark = "",
--                 modified = "",
--                 hidden = "󱙝",
--                 git = {
--                     unstaged = "×",
--                     staged = "",
--                     unmerged = "󰧾",
--                     untracked = "",
--                     renamed = "",
--                     deleted = "",
--                     ignored = "∅"
--                 }
--             }
--         }
--     },
--     filters = {
--         git_ignored = false
--     },
--     hijack_cursor = true,
--     sync_root_with_cwd = true
-- }
