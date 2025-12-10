vim.pack.add({
    { src = 'https://github.com/nvim-lualine/lualine.nvim' }
})


-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#080808',
    white  = '#c6c6c6',
    red    = '#ff5189',
    violet = '#d183e8',
    grey   = '#303030',
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white },
    },

    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
    },
}

local filename = {
    'filename',
    file_status = true,    -- Displays file status (readonly status, modified status)
    newfile_status = true, -- Display new file status (new file means no write after created)
    path = 0,              -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory
    -- 4: Filename and parent dir, with tilde as the home directory

    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
    -- for other components. (terrible name, any suggestions?)
    -- It can also be a function that returns
    -- the value of `shorting_target` dynamically.
    symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for newly created file before first write
    }
}

local filetype = {
    'filetype',
    colored = true,            -- Displays filetype icon in color if set to true
    icon_only = false,         -- Display only an icon for filetype
    icon = { align = 'left' }, -- Display filetype icon on the right hand side
    -- icon =    {'X', align='right'}
    -- Icon string ^ in table is ignored in filetype component
}

local diagnostics = {
    'diagnostics',

    -- Table of diagnostic sources, available sources are:
    --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
    -- or a function that returns a table as such:
    --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
    sources = { 'nvim_diagnostic' },

    -- Displays diagnostics for the defined severity types
    sections = { 'error', 'warn', 'info', 'hint' },

    diagnostics_color = {
        -- Same values as the general color option can be used here.
        error = 'DiagnosticError', -- Changes diagnostics' error color.
        warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
        info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
        hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
    },
    symbols = { error = '󰅚 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' },
    colored = true,           -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = false,   -- Show diagnostics even if there are none.
}

local diff = {
    'diff',
    colored = true, -- Displays a colored diff status if set to true
    diff_color = {
        -- Same color values as the general color option can be used here.
        added    = 'LuaLineDiffAdd',                          -- Changes the diff's added color
        modified = 'LuaLineDiffChange',                       -- Changes the diff's modified color
        removed  = 'LuaLineDiffDelete',                       -- Changes the diff's removed color you
    },
    symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
    source = nil,                                             -- A function that works as a data source for diff.
    -- It must return a table as such:
    --   { added = add_count, modified = modified_count, removed = removed_count }
    -- or nil on failure. count <= 0 won't be displayed.
}

local lsp_status = {
    'lsp_status',
    icon = '', -- f013
    symbols = {
        -- Standard unicode symbols to cycle through for LSP progress:
        spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        -- Standard unicode symbol for when LSP is done:
        done = '✓',
        -- Delimiter inserted between LSP names:
        separator = ' ',
    },
    -- List of LSP names to ignore (e.g., `null-ls`):
    ignore_lsp = {},
    -- Display the LSP name
    show_name = true,
}


require('lualine').setup({
    options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { filename, 'branch', diff },
        lualine_c = {
            '%=', --[[ add your center components here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { filetype, diagnostics, lsp_status, 'progress' },
        lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
        },
    },
    inactive_sections = {
        lualine_a = { { 'filename', path = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
})
