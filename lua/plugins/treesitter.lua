vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' }
})

local parsers = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "go",
    "rust",
    "javascript",
    "typescript",
    "prisma",
    "python",
}

local treesitter = require('nvim-treesitter')

treesitter.setup()

local available = {}
for _, parser in ipairs(treesitter.get_available()) do
    available[parser] = true
end

local installs = {}

local function start(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        return
    end

    pcall(vim.treesitter.start, buf)
end

local function ensure_installed(parser, buf)
    if not parser or not available[parser] then
        return
    end

    if vim.tbl_contains(treesitter.get_installed('parsers'), parser) then
        if buf then
            start(buf)
        end
        return
    end

    local install = installs[parser]
    if not install then
        install = { buffers = {} }
        installs[parser] = install
        if buf then
            install.buffers[buf] = true
        end

        install.task = treesitter.install(parser)
        install.task:await(function(err, success)
            vim.schedule(function()
                installs[parser] = nil
                if err or not success then
                    return
                end

                for pending_buf in pairs(install.buffers) do
                    start(pending_buf)
                end
            end)
        end)
    elseif buf then
        install.buffers[buf] = true
    end
end

for _, parser in ipairs(parsers) do
    ensure_installed(parser)
end

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local buf = args.buf
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return
        end
        local parser = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
            or vim.bo[buf].filetype
        ensure_installed(parser, buf)
    end,
})
