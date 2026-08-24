vim.pack.add({
    { src = 'https://github.com/ibhagwan/fzf-lua' }
})


require("fzf-lua").setup({
    files = {
        git_icons = true,
    },
    winopts = {
        preview = {
            layout = "vertical",
            vertical = "down:70%",
            height = 0.85,
            width = 0.85,
        },
    },
})

-- Used by lsp_code_actions() and other vim.ui.select callers
require("fzf-lua").register_ui_select()
