vim.pack.add({
    { src = 'https://github.com/dlyongemallo/diffview-plus.nvim' }
})

require('diffview').setup({
    view = {
        default = {
            layout = 'diff1_inline',
        },
        merge_tool = {
            layout = 'diff1_plain',
        },
        file_history = {
            layout = 'diff1_inline',
        },
        inline = {
            style = 'unified',
        },
    },
})
