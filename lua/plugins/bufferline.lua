vim.pack.add({
    { src = 'https://github.com/akinsho/bufferline.nvim' }
})
require("bufferline").setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true -- use a "true" to enable the default, or set your own character
            }
        }
    }
})
