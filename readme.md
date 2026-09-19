# Neovim Configuration

Neovim configuration with plugins and settings.

## Requirements

nvim version >= 0.12.0

Tree-sitter requires `tree-sitter` CLI >= 0.26.1, a C compiler, `curl`, and `tar`.
Use the `main` branch of `nvim-treesitter`; the legacy `master` query handlers
are incompatible with Neovim 0.12. Changing the branch in the configuration
alone does not update an existing installation. To migrate one, run
`:lua vim.pack.update({ 'nvim-treesitter' }, { force = true })`, restart Neovim,
and run `:TSUpdate`.

## Install Dependencies

```shell 
npm i -g cssmodules-language-server vscode-langservers-extracted @vtsls/language-server typescript @prisma/language-server oxlint oxfmt bash-language-server
```

```shell
brew install lua-language-server
```

## JavaScript / TypeScript, Shell and QML

- `vtsls` replaces the enabled `ts_ls` server for JavaScript and TypeScript.
- Oxc uses `oxlint --lsp` for diagnostics and `:LspOxlintFixAll` for fixes.
  Project-local `node_modules/.bin/oxlint` takes precedence over the global executable.
- JavaScript / TypeScript formatting uses `oxfmt`, falling back to `prettier` when unavailable.
- Shell / Bash uses `bash-language-server`. Install `shellcheck` for diagnostics and
  `shfmt` for formatting using your system package manager.
- QML uses Qt 6's `qmlls` (or `qmlls6`) and `qmlformat`. Install the Qt declarative
  development tools for your distribution and ensure the executables are on `PATH`.
- Treesitter installs the `bash`, `qmljs`, and `tsx` parsers for highlighting.

Check language servers with `:checkhealth vim.lsp` and formatters with `:ConformInfo`.

## Completion

`blink.cmp` provides automatic completion from LSP, paths, snippets, and buffer words.
It uses Neovim's built-in snippet engine and downloads a prebuilt fuzzy matcher
for the installed 1.x release, with a Lua fallback if unavailable.

- `Ctrl-O` / `Ctrl-Space`: open completion or toggle documentation.
- `Ctrl-J` / `Ctrl-K`: select the next / previous suggestion.
- `Enter`: accept; `Escape`: close the menu (or leave Insert mode when it is closed).
- `Ctrl-B` / `Ctrl-F`: scroll documentation.
- `Ctrl-S` / `Ctrl-H`: jump to the next / previous snippet placeholder.

Copilot uses `Alt-Enter` to accept and `Alt-K` to accept the next line;
`Ctrl-N` / `Ctrl-P` still cycle its suggestions. Command-line completion is unchanged.

## Search

[fff](https://github.com/dmtrKovalenko/fff) provides file and content search:

- `<leader>ff`: find files.
- `<leader>fg`: live grep (`Shift-Tab` switches grep modes).
- `<leader>fb`: open buffers via Snacks Picker.

The existing LSP navigation, symbols and diagnostics mappings use Snacks Picker.
`ga` uses native LSP code actions with Snacks providing `vim.ui.select`.
Dashboard search shortcuts use fff as well.

The `vim.pack` install/update hook downloads fff's native binary using `curl`,
falling back to a Rust build (`rustup` and `cargo`) if necessary. Wait for it to
finish before opening a picker. Use `:FFFHealth` to check the installation.

## Structure

- `lua/plugins/` - plugins
- `lua/config/` - settings (options, keybinds, lsp, diagnostic)
- `lua/custom_plugins/` - custom plugins
- `lua/themes/` - themes
- `lsp/` - LSP servers
