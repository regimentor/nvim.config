vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable({
    'lua_ls',
    'rust_analyzer',
    'vtsls',
    'oxlint',
    'bashls',
    'qmlls',
    'eslint',
    'prismals',
    'cssmodules_ls',
    'jsonls',
    'pyright',
    'csharp_ls',
    'gdscript',
})

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(ev)
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        local opts = { buffer = ev.buf, silent = true }
        -- ============================================================================
        -- LSP pickers
        -- ============================================================================
        -- Navigation
        vim.keymap.set("n", "gR", function()
            Snacks.picker.lsp_references()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP references" }))

        vim.keymap.set("n", "gD", function()
            vim.lsp.buf.declaration()
        end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

        vim.keymap.set("n", "gd", function()
            Snacks.picker.lsp_definitions()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP definitions" }))

        vim.keymap.set("n", "gi", function()
            Snacks.picker.lsp_implementations()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP implementations" }))

        vim.keymap.set("n", "gt", function()
            Snacks.picker.lsp_type_definitions()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" }))

        -- Code actions
        vim.keymap.set({ "n", "v" }, "ga", function()
            vim.lsp.buf.code_action()
        end, vim.tbl_extend("force", opts, { desc = "See available code actions" }))

        vim.keymap.set("n", "gr", function()
            vim.lsp.buf.rename()
        end, vim.tbl_extend("force", opts, { desc = "Smart rename" }))

        -- Diagnostics
        vim.keymap.set("n", "gb", function()
            Snacks.picker.diagnostics_buffer()
        end, vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" }))

        vim.keymap.set("n", "gB", function()
            Snacks.picker.diagnostics({ filter = { cwd = false } })
        end, vim.tbl_extend("force", opts, { desc = "Show workspace diagnostics" }))

        vim.keymap.set("n", "D", function()
            vim.diagnostic.open_float()
        end, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))

        vim.keymap.set("n", "gs", function()
            Snacks.picker.lsp_symbols({ filter = { default = true, lua = true } })
        end, vim.tbl_extend("force", opts, { desc = "Show Document Symbols" }))

        vim.keymap.set("n", "gS", function()
            Snacks.picker.lsp_workspace_symbols({ filter = { default = true, lua = true } })
        end, vim.tbl_extend("force", opts, { desc = "Show workspace Symbols" }))

    end,
})
