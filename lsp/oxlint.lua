---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        local command = 'oxlint'
        if config.root_dir then
            local local_command = vim.fs.joinpath(config.root_dir, 'node_modules', '.bin', command)
            if vim.fn.executable(local_command) == 1 then
                command = local_command
            end
        end
        return vim.lsp.rpc.start({ command, '--lsp' }, dispatchers)
    end,
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'astro' },
    root_markers = { '.oxlintrc.json', '.oxlintrc.jsonc', 'oxlint.config.ts', 'package.json', '.git' },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'LspOxlintFixAll', function()
            client:exec_cmd({
                title = 'Apply Oxlint automatic fixes',
                command = 'oxc.fixAll',
                arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
            })
        end, { desc = 'Apply Oxlint automatic fixes' })
    end,
}
