---@type vim.lsp.Config
return {
    cmd = { 'vtsls', '--stdio' },
    init_options = { hostInfo = 'neovim' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, {
            { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' },
            '.git',
        })
        local deno = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
        local deno_lock = vim.fs.root(bufnr, { 'deno.lock' })
        if deno and (not root or #deno >= #root) then
            return
        end
        if deno_lock and (not root or #deno_lock > #root) then
            return
        end
        on_dir(root or vim.fn.getcwd())
    end,
}
