---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        local command = vim.fn.exepath('csharp-ls')
        if command == '' then
            command = vim.fn.expand('~/.dotnet/tools/csharp-ls')
        end
        return vim.lsp.rpc.start({ command }, dispatchers, {
            cwd = config.root_dir,
        })
    end,
    filetypes = { 'cs' },
    root_dir = function(bufnr, on_dir)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        -- Prefer the solution so references between projects are available.
        local function root_for(extensions)
            return vim.fs.root(filename, function(name)
                for _, extension in ipairs(extensions) do
                    if vim.endswith(name, extension) then
                        return true
                    end
                end
                return false
            end)
        end
        local root = root_for({ '.sln', '.slnx' }) or root_for({ '.csproj' })
        if root then
            on_dir(root)
        end
    end,
    init_options = { AutomaticWorkspaceInit = true },
    get_language_id = function()
        return 'csharp'
    end,
}
