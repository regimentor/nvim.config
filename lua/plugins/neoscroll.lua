vim.pack.add({
    { src = 'https://github.com/karb94/neoscroll.nvim' }
})

require('neoscroll').setup({
    stop_eof = false, -- Allow scrolling past the end of the buffer.
})
