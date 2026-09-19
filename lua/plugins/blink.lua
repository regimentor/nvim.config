vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1') },
})

require('blink.cmp').setup({
    -- Keep Copilot's Ctrl-N/P and Ctrl-I (Tab) mappings available.
    keymap = {
        preset = 'none',
        ['<C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Esc>'] = { 'hide', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-s>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },
    completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = { auto_show = true },
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    cmdline = { enabled = false },
})
