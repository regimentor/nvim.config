vim.pack.add({
    { src = 'https://github.com/andythigpen/nvim-coverage' }
})

require('coverage').setup({
    auto_reload = true,
})
