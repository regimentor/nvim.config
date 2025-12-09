vim.lsp.enable({
    'lua_ls',
    'rust_analyzer',
    'ts_ls',
    'eslint',
    'prismals',
    'cssmodules_ls',
    'jsonls'
})

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(ev)
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        local opts = { buffer = ev.buf, silent = true }
        -- ============================================================================
        -- fzf plugin
        -- ============================================================================
        local fzf_lua = require("fzf-lua")
        -- Navigation
        vim.keymap.set("n", "gR", function()
            fzf_lua.lsp_references()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP references" }))

        vim.keymap.set("n", "gD", function()
            vim.lsp.buf.declaration()
        end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

        vim.keymap.set("n", "gd", function()
            fzf_lua.lsp_definitions()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP definitions" }))

        vim.keymap.set("n", "gi", function()
            fzf_lua.lsp_implementations()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP implementations" }))

        vim.keymap.set("n", "gt", function()
            fzf_lua.lsp_typedefs()
        end, vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" }))

        -- Code actions
        vim.keymap.set({ "n", "v" }, "ga", function()
            fzf_lua.lsp_code_actions()
        end, vim.tbl_extend("force", opts, { desc = "See available code actions" }))

        vim.keymap.set("n", "gr", function()
            vim.lsp.buf.rename()
        end, vim.tbl_extend("force", opts, { desc = "Smart rename" }))

        -- Diagnostics
        vim.keymap.set("n", "gb", function()
            fzf_lua.diagnostics_document()
        end, vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" }))

        vim.keymap.set("n", "gB", function()
            fzf_lua.diagnostics_workspace()
        end, vim.tbl_extend("force", opts, { desc = "Show workspace diagnostics" }))

        vim.keymap.set("n", "D", function()
            vim.diagnostic.open_float()
        end, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))

        vim.keymap.set("n", "gs", function()
            fzf_lua.lsp_document_symbols()
        end, vim.tbl_extend("force", opts, { desc = "Show Document Symbols" }))

        vim.keymap.set("n", "gS", function()
            fzf_lua.lsp_workspace_symbols()
        end, vim.tbl_extend("force", opts, { desc = "Show workspace Symbols" }))

        -- ============================================================================
        -- completion
        -- ============================================================================
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-o>', function()
                vim.lsp.completion.get()
            end)
        end
    end,
})
