vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('fff_binary', { clear = true }),
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'fff' and (kind == 'install' or kind == 'update') then
            if not ev.data.active then
                vim.cmd.packadd('fff')
            end
            require('fff.download').download_or_build_binary()
        end
    end,
})

vim.g.fff = {
    lazy_sync = true,
    keymaps = {
        move_up = { '<Up>', '<C-p>', '<C-k>' },
        move_down = { '<Down>', '<C-n>', '<C-j>' },
    },
    layout = {
        height = 0.85,
        width = 0.85,
        preview_position = 'bottom',
        preview_size = 0.7,
    },
}

vim.pack.add({
    { src = 'https://github.com/dmtrKovalenko/fff' },
})
