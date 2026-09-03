vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
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
                    action = ":NvimTreeFocus",
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
            { section = "keys", gap = 1, padding = 1 },
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

-- Treat `nvim .` like a project start instead of letting nvim-tree replace
-- the initial buffer. Opening nvim-tree explicitly still works via <leader>e.
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
