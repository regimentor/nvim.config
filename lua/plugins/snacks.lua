vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
    image = { enabled = true },
    -- fff handles files and grep; Snacks handles buffers, LSP and code actions.
    picker = {
        enabled = true,
        ui_select = true,
        sources = {
            explorer = {
                hidden = true,
                ignored = true,
                layout = { preset = 'sidebar', layout = { width = 35 } },
            },
        },
    },
    -- Keep `nvim .` opening the project dashboard.
    explorer = { enabled = true, diagnostic = true, replace_netrw = false, git_status = true },
    scroll = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    terminal = { enabled = true },
    bigfile = { enabled = true },
    words = { enabled = true },
    dashboard = {
        enabled = true,
        preset = {
            keys = {
                {
                    icon = " ",
                    key = "f",
                    desc = "Find file",
                    action = "<leader>ff",
                },
                {
                    icon = " ",
                    key = "g",
                    desc = "Find text",
                    action = "<leader>fg",
                },
                {
                    icon = " ",
                    key = "e",
                    desc = "File explorer",
                    action = "<leader>e",
                },
                {
                    icon = " ",
                    key = "d",
                    desc = "Diff page",
                    action = "<leader>hd",
                },
                {
                    icon = " ",
                    key = "q",
                    desc = "Quit",
                    action = ":qa",
                },
            },
        },
        sections = {
            { section = "header" },
            { section = "keys",  gap = 1, padding = 1 },
            {
                icon = " ",
                title = "Recent files",
                section = "recent_files",
                cwd = true,
                indent = 2,
                padding = 1,
            },
        },
    },
})

-- vim.pack may load Snacks after UIEnter; initialize its UI integrations now.
Snacks.picker.setup()
Snacks.input.enable()
Snacks.scroll.enable()

-- Treat `nvim .` like a project start. Open the explorer via <leader>e.
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("project_dashboard", { clear = true }),
    once = true,
    callback = function(args)
        if vim.fn.argc(-1) ~= 1 then
            return
        end

        local directory = vim.fn.fnamemodify(vim.fn.argv(0), ":p")
        if vim.fn.isdirectory(directory) ~= 1 then
            return
        end

        vim.api.nvim_set_current_dir(directory)
        vim.cmd("argdelete *")
        vim.api.nvim_buf_set_name(args.buf, "")
    end,
})

-- vim.pack loads this module after UIEnter, while Snacks normally hooks that
-- event itself. Run the startup check at VimEnter for native package loading.
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("snacks_dashboard_startup", { clear = true }),
    once = true,
    callback = function()
        if not Snacks.dashboard.status.did_setup then
            Snacks.dashboard.setup()
        end
    end,
})
