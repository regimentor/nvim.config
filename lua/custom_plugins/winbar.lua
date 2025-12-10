function _G.WinbarIcon()
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if not ok then
        return ""
    end

    local filename = vim.fn.expand("%:t")
    if filename == "" then
        return ""
    end

    local icon, _ = devicons.get_icon(filename, nil, { default = true })
    return icon or ""
end

function _G.WinbarPath()
    local filepath = vim.fn.expand("%:p")
    if filepath == "" then
        return ""
    end

    local relative_path = vim.fn.fnamemodify(filepath, ":~:.")

    local path_with_arrows = relative_path:gsub("/", "  ")

    return path_with_arrows
end

vim.o.winbar = "%#WinBar# %{v:lua.WinbarIcon()} %{v:lua.WinbarPath()} "
