-- Diagnostics
vim.diagnostic.config({
    -- Use the default configuration
    -- virtual_lines = true
    -- Alternatively, customize specific options
    -- virtual_lines = {
    --     -- Only show virtual line diagnostics for the current cursor line
    --     current_line = false
    -- },
    virtual_lines = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
    },
    underline = {
        severity = vim.diagnostic.severity.ERROR,
    },
    virtual_text = true,     -- Enable virtual text for diagnostics
    update_in_insert = true, -- Keep diagnostics active in insert mode
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶",
        },
    },
})
