local M = {}

local function link_at_cursor(line, column)
    local patterns = {
        '%f[%[]%[%[([^]%[]+)%]%]', -- [[note]] or [[note#heading]]
        '%f[%[]%[[^]%[]+%]%(([^)]+)%)', -- [label](path.md)
    }
    for _, pattern in ipairs(patterns) do
        local offset = 1
        while true do
            local first, last, target = line:find(pattern, offset)
            if not first then
                break
            end
            if column >= first and column <= last then
                return target
            end
            offset = last + 1
        end
    end
end

local function slug(heading)
    return vim.fn.tolower(heading):gsub('[`*_]', ''):gsub('%-', ' '):gsub('[%p]', ''):gsub('%s+', '-')
end

function M.follow()
    local line = vim.api.nvim_get_current_line()
    local column = vim.api.nvim_win_get_cursor(0)[2] + 1
    local target = link_at_cursor(line, column)
    if not target then
        vim.cmd.normal({ 'gf', bang = true })
        return
    end

    target = target:match('^<([^>]+)>') or target:match('^(%S+)')
    if not target or target:match('^%a[%w+.-]*://') or target:match('^mailto:') then
        vim.notify('Not a local Markdown link', vim.log.levels.INFO)
        return
    end

    local path, anchor = target:match('^([^#]*)#?(.*)$')
    path = path:gsub('%%(%x%x)', function(hex)
        return string.char(tonumber(hex, 16))
    end)
    local current = vim.api.nvim_buf_get_name(0)
    local root = vim.fs.root(0, { '.marksman.toml', '.git' }) or vim.fn.getcwd()
    local filename = path == '' and current
        or vim.fs.normalize(path:sub(1, 1) == '/'
            and vim.fs.joinpath(root, path:sub(2))
            or vim.fs.joinpath(vim.fs.dirname(current), path))
    if vim.fn.filereadable(filename) == 0 and vim.fn.filereadable(filename .. '.md') == 1 then
        filename = filename .. '.md'
    end
    if vim.fn.filereadable(filename) == 0 then
        vim.notify('Markdown target not found: ' .. filename, vim.log.levels.WARN)
        return
    end

    vim.cmd.edit(vim.fn.fnameescape(filename))
    if anchor ~= '' then
        for row, heading in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
            local title = heading:match('^%s*#+%s+(.+)%s*$')
            if title and slug(title) == vim.fn.tolower(anchor) then
                vim.api.nvim_win_set_cursor(0, { row, 0 })
                return
            end
        end
        vim.notify('Markdown heading not found: #' .. anchor, vim.log.levels.WARN)
    end
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function(ev)
        vim.keymap.set('n', 'gf', M.follow, { buffer = ev.buf, desc = 'Follow local Markdown link' })
    end,
})

return M
