vim.pack.add({
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' }
})

require("nvim-tree").setup({
    hijack_cursor = true,
    sync_root_with_cwd = true,
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 35,
    },
    modified = {
        enable = true
    },
    filters = {
        dotfiles = false,
    },
    git = {
        ignore = false,
    },
    renderer = {
        group_empty = true,
        indent_width = 1,
        icons = {
            git_placement = "after",
            bookmarks_placement = "after",
            glyphs = {
                modified = "",
                git = {
                    renamed = "",
                    deleted = "",
                    untracked = "",
                    ignored = "·",
                    unstaged = "",
                    staged = "✓",
                }
            }
        }
    },
})
