# Neovim Config (kresna)

A [lazy.nvim](https://github.com/folke/lazy.nvim)-managed Neovim setup with LSP
(via lsp-zero), fuzzy finding (Telescope + fzf-native), Git integration, a
terminal, Rust/Go tooling, and ChatGPT.

**Leader key:** `<Space>`

## Structure

```
init.lua                      -- entrypoint (loads basic + lazy)
lua/kresna/
├── basic/
│   ├── options.lua           -- editor options
│   └── keymaps.lua           -- general (non-plugin) keymaps
├── lazy.lua                  -- bootstrap lazy.nvim + cmp/lsp/which-key wiring
└── plugins/                  -- one file per plugin spec
```

## Requirements

- Neovim **0.10+** (developed on 0.12)
- `git`, `make`, and a C compiler (`cc`/`gcc`) — needed to build `telescope-fzf-native`
- [`fzf`](https://github.com/junegunn/fzf) — fuzzy finder
- A [Nerd Font](https://www.nerdfonts.com/) — for devicons in the file tree, statusline, and bufferline
- A true-color terminal (iTerm2, WezTerm, Kitty, …) — `termguicolors` is on
- `OPENAI_API_KEY` in your environment — for ChatGPT.nvim
- Language servers are installed on demand via **Mason** (`:Mason`)

> **fzf-native build:** if you ever see `'fzf' extension doesn't exist or isn't installed`,
> the native library failed to compile. Rebuild with `:Lazy build telescope-fzf-native.nvim`,
> or manually: `cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make`.

---

## Plugins

| Plugin | Purpose |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim) | LSP setup made simple (v3.x) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) + [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) | Install/manage language servers |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configs |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Autocompletion & snippets |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native fzf sorter for Telescope |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting / parsing |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs + inline blame |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Git diff & merge-conflict resolution |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Integrated terminal |
| [flatten.nvim](https://github.com/willothy/flatten.nvim) | Open files from a nested nvim in the parent instance |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tab/buffer line |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline (dracula theme) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup showing available keybindings |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes |
| [rose-pine](https://github.com/rose-pine/neovim) | Colorscheme (moon variant) |
| [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) | Rust: inlay hints, hover actions, rust-analyzer |
| [go.nvim](https://github.com/ray-x/go.nvim) | Go: format/imports on save, tooling |
| [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim) | ChatGPT in the editor |

---

## Keybindings

### General (`lua/kresna/basic/keymaps.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>p` | Visual | Paste over selection without overwriting the register |
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `gl` | Normal | Show diagnostics in a floating window |

#### Window splits

| Key | Action |
| --- | --- |
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<C-w> h/j/k/l` | Move between windows |

#### Tabs

| Key | Action |
| --- | --- |
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Go to next tab |
| `<leader>tp` | Go to previous tab |
| `<leader>tf` | Open current buffer in a new tab |

### Telescope

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |

### nvim-tree (file explorer)

| Key | Action |
| --- | --- |
| `<leader>ef` | Focus the file explorer |
| `<leader>ee` | Toggle explorer on the current file |
| `<leader>ec` | Collapse the explorer |
| `<leader>er` | Refresh the explorer |

Inside the tree, the plugin's [default keymaps](https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt) apply
(`<CR>`/`o` open, `a` create, `d` delete, `r` rename, `x` cut, `c` copy, `p` paste, `H` toggle hidden, `?` help, …).

### LSP (active in buffers with a language server attached)

Provided by lsp-zero's default keymaps.

| Key | Action |
| --- | --- |
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `go` | Go to type definition |
| `gr` | List references |
| `gs` | Signature help |
| `<F2>` | Rename symbol |
| `<F3>` | Format buffer |
| `<F4>` | Code action |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Completion (nvim-cmp, insert mode)

| Key | Action |
| --- | --- |
| `<CR>` | Confirm completion |
| `<C-Space>` | Trigger completion menu |
| `<C-u>` | Scroll docs up |
| `<C-d>` | Scroll docs down |
| `<C-f>` | Jump to next snippet placeholder |
| `<C-b>` | Jump to previous snippet placeholder |

### toggleterm (integrated terminal)

| Key | Mode | Action |
| --- | --- | --- |
| `<C-\>` | Normal/Terminal | Toggle the terminal |
| `<Esc>` or `jk` | Terminal | Exit terminal (to normal) mode |
| `<C-h/j/k/l>` | Terminal | Move to the window left/down/up/right |
| `<C-w>` | Terminal | Window command prefix |

### diffview (Git diff / merge conflicts)

Open with `:DiffviewOpen`, file history with `:DiffviewFileHistory`, close with `:DiffviewClose`.

| Key | Action |
| --- | --- |
| `<tab>` / `<s-tab>` | Next / previous changed file |
| `<leader>e` | Focus the file panel |
| `<leader>b` | Toggle the file panel |
| `gf` | Open the file in the previous tab |
| `<leader>co` | Conflict: choose **ours** |
| `<leader>ct` | Conflict: choose **theirs** |
| `<leader>cb` | Conflict: choose **base** |
| `<leader>ca` | Conflict: choose **all** |
| `<leader>cO` | Conflict: choose ours for the whole file |
| `dx` | Conflict: delete the conflict region |

The plugin's default keymaps also apply (`[x` / `]x` to jump between conflicts, `co`/`ct`/`cb` on a hunk, etc.).

### ChatGPT (`<leader>c` prefix)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>cc` | Normal | Open ChatGPT |
| `<leader>ce` | Normal/Visual | Edit with instruction |
| `<leader>cg` | Normal/Visual | Grammar correction |
| `<leader>ct` | Normal/Visual | Translate |
| `<leader>ck` | Normal/Visual | Keywords |
| `<leader>cd` | Normal/Visual | Docstring |
| `<leader>ca` | Normal/Visual | Add tests |
| `<leader>co` | Normal/Visual | Optimize code |
| `<leader>cs` | Normal/Visual | Summarize |
| `<leader>cf` | Normal/Visual | Fix bugs |
| `<leader>cx` | Normal/Visual | Explain code |
| `<leader>cr` | Normal/Visual | Roxygen edit |
| `<leader>cl` | Normal/Visual | Code readability analysis |

### which-key

Press `<leader>` (or any mapped prefix) and wait ~0.9s — a popup lists the
available follow-up keys. No manual binding needed.

---

## Language-specific tooling

- **Rust** — `rust-tools.nvim` drives rust-analyzer with inlay hints on. Use
  `:RustHoverActions`, `:RustRunnables`, `:RustExpandMacro`, etc. Requires
  `rust-analyzer` (installable via Mason or rustup).
- **Go** — `go.nvim` runs `goimports` automatically on save (`BufWritePre` for
  `*.go`). Commands like `:GoFmt`, `:GoImport`, `:GoTest`, `:GoRun` are available.
  Run `:GoInstallBinaries` once to install the Go tools.

---

## Notes

- Deprecation warnings from pinned plugins are silenced at the top of `init.lua`
  (`vim.deprecate = function() end`). Run `:checkhealth vim.deprecated` any time
  to see what's actually deprecated.
- Colorscheme is **rose-pine** (moon); lualine uses the **dracula** theme.
- `neo-tree.lua_disable` and `typescript-tools.lua_disable` are disabled specs —
  rename them back to `.lua` to re-enable.
