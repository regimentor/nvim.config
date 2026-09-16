---@type vim.lsp.Config
return {
    cmd = { vim.fn.executable('qmlls') == 1 and 'qmlls' or 'qmlls6' },
    filetypes = { 'qml', 'qmljs' },
    root_markers = { '.qmlls.ini', 'CMakeLists.txt', '.git' },
}
