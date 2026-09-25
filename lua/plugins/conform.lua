vim.pack.add({
    { src = 'https://github.com/stevearc/conform.nvim' }
})

require("conform").setup({
    -- Map of filetype to formatters
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        go = { "goimports", "gofmt" },
        -- You can also customize some of the format options for the filetype
        rust = { "rustfmt", lsp_format = "fallback" },
        cs = { lsp_format = "fallback" },
        gdscript = { "gdformat", lsp_format = "fallback" },

        javascript = { "oxfmt", "prettier", stop_after_first = true },
        javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
        sh = { "shfmt" },
        bash = { "shfmt" },
        qml = { "qmlformat" },
        qmljs = { "qmlformat" },
    },
    formatters = {
        -- Older installed Conform versions do not include oxfmt yet.
        oxfmt = {
            command = require("conform.util").from_node_modules("oxfmt"),
            args = { "--stdin-filepath", "$FILENAME" },
            stdin = true,
            cwd = require("conform.util").root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts", "package.json" }),
        },
    },
    -- Set this to change the default values when calling conform.format()
    -- This will also affect the default values for format_on_save/format_after_save
    default_format_opts = {
        lsp_format = "fallback",
    },
    -- If this is set, Conform will run the formatter on save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    -- NOTE: On some Neovim/conform combinations sync formatting in BufWritePre
    -- can fail with: "timeout has no integer representation".
    -- Keep formatting on save via async hook below to avoid this crash.
    format_on_save = false,
    -- If this is set, Conform will run the formatter asynchronously after save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_after_save = {
        lsp_format = "fallback",
    },
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
})
