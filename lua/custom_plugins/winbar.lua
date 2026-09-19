local function set_highlights()
    vim.api.nvim_set_hl(0, "WinBarDiagnosticError", { fg = "#ff6c6b", bold = true })
    vim.api.nvim_set_hl(0, "WinBarDiagnosticWarn", { fg = "#ffb86c", bold = true })
    vim.api.nvim_set_hl(0, "WinBarDiagnosticInfo", { fg = "#7fdbff", bold = true })
    vim.api.nvim_set_hl(0, "WinBarDiagnosticHint", { fg = "#98be65", bold = true })
    vim.api.nvim_set_hl(0, "WinBarModified", { fg = "#ff6c6b", bold = true })
end

local function update_winbar()
    local filepath = vim.fn.expand("%:p")
    if filepath == "" then
        vim.wo.winbar = ""
        return
    end

    local relative_path = vim.fn.fnamemodify(filepath, ":~:.")
    local ok, devicons = pcall(require, "nvim-web-devicons")

    local parts = {}
    for part in relative_path:gmatch("[^/]+") do
        table.insert(parts, part)
    end

    local result = {}
    for i, part in ipairs(parts) do
        local icon = ""
        local is_last = i == #parts
        if is_last then
            if ok then
                icon = devicons.get_icon(part, nil, { default = true })
            end
            if not icon then
                icon = ""
            end
        else
            icon = ""
        end
        table.insert(result, icon .. " " .. part:gsub("%%", "%%%%"))
    end

    local path_str = table.concat(result, "  ")

    local diagnostics = vim.diagnostic.get(0)
    local error_count = 0
    local warn_count = 0
    local info_count = 0
    local hint_count = 0

    for _, diag in ipairs(diagnostics) do
        if diag.severity == vim.diagnostic.severity.ERROR then
            error_count = error_count + 1
        elseif diag.severity == vim.diagnostic.severity.WARN then
            warn_count = warn_count + 1
        elseif diag.severity == vim.diagnostic.severity.INFO then
            info_count = info_count + 1
        elseif diag.severity == vim.diagnostic.severity.HINT then
            hint_count = hint_count + 1
        end
    end

    local winbar_str = "%#WinBar# " .. path_str

    if vim.bo.modified then
        winbar_str = winbar_str .. " %#WinBarModified#%#WinBar#"
    end

    if error_count > 0 or warn_count > 0 or info_count > 0 or hint_count > 0 then
        winbar_str = winbar_str .. " | "
        if error_count > 0 then
            winbar_str = winbar_str .. "%#WinBarDiagnosticError#󰅚 " .. error_count .. "%#WinBar# "
        end
        if warn_count > 0 then
            winbar_str = winbar_str .. "%#WinBarDiagnosticWarn#󰀪 " .. warn_count .. "%#WinBar# "
        end
        if info_count > 0 then
            winbar_str = winbar_str .. "%#WinBarDiagnosticInfo#󰋽 " .. info_count .. "%#WinBar# "
        end
        if hint_count > 0 then
            winbar_str = winbar_str .. "%#WinBarDiagnosticHint#󰌶 " .. hint_count .. "%#WinBar# "
        end
    end

    vim.wo.winbar = winbar_str
end

local group = vim.api.nvim_create_augroup("CustomWinbar", { clear = true })

local function update_windows(buf)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if (not buf or vim.api.nvim_win_get_buf(win) == buf)
            and vim.api.nvim_win_get_config(win).relative == "" then
            vim.api.nvim_win_call(win, update_winbar)
        end
    end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "BufFilePost", "BufWritePost", "DiagnosticChanged", "BufModifiedSet" }, {
    group = group,
    callback = function(ev)
        update_windows(ev.buf)
    end,
})

vim.api.nvim_create_autocmd("DirChanged", {
    group = group,
    callback = function()
        update_windows()
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
        set_highlights()
        update_windows()
    end,
})

set_highlights()
update_windows()
