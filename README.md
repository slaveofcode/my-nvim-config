# Neovim Config (kresna)

A [lazy.nvim](https://github.com/folke/lazy.nvim)-managed Neovim setup with LSP
(via lsp-zero), fuzzy finding (Telescope + fzf-native), Git integration, a
terminal, Rust/Go tooling, ChatGPT, and Markdown preview.

> **This README is your cheat sheet.** Whenever you forget how a plugin works,
> come back here — every plugin has its commands, shortcuts, and a short
> "how to use" below.

**Leader key:** `<Space>` (written as `<leader>`)

## Table of contents

- [Structure](#structure)
- [Requirements](#requirements)
- [Managing plugins (lazy.nvim)](#managing-plugins-lazynvim)
- [General keymaps](#general-keymaps)
- [Plugin guide](#plugin-guide) — commands, shortcuts & how-to for every plugin
  - [Telescope — fuzzy finder](#telescope--fuzzy-finder)
  - [nvim-tree — file explorer](#nvim-tree--file-explorer)
  - [LSP (lsp-zero + Mason)](#lsp-lsp-zero--mason)
  - [nvim-cmp — autocompletion](#nvim-cmp--autocompletion)
  - [Treesitter](#treesitter)
  - [gitsigns — git in the gutter](#gitsigns--git-in-the-gutter)
  - [diffview — diffs & merge conflicts](#diffview--diffs--merge-conflicts)
  - [toggleterm — terminal](#toggleterm--terminal)
  - [flatten — open files from terminal](#flatten--open-files-from-terminal)
  - [bufferline — tab line](#bufferline--tab-line)
  - [markdown-preview](#markdown-preview)
  - [ChatGPT](#chatgpt)
  - [rust-tools — Rust](#rust-tools--rust)
  - [go.nvim — Go](#gonvim--go)
  - [which-key](#which-key)
  - [Passive plugins](#passive-plugins-no-keys-needed)

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
- `git`, `make`, and a C compiler (`cc`/`gcc`) — to build `telescope-fzf-native`
- [`fzf`](https://github.com/junegunn/fzf) — fuzzy finder
- `node` — for markdown-preview (the binary is auto-downloaded on install)
- A [Nerd Font](https://www.nerdfonts.com/) — icons in the tree, statusline, bufferline
- A true-color terminal (iTerm2, WezTerm, Kitty, …) — `termguicolors` is on
- `OPENAI_API_KEY` in your environment — for ChatGPT
- Language servers install on demand via **Mason** (`:Mason`)

---

## Managing plugins (lazy.nvim)

Open the plugin manager UI with **`:Lazy`**. Inside it, single keys act on plugins:

| Command | What it does |
| --- | --- |
| `:Lazy` | Open the dashboard (press `?` for help, `q` to quit) |
| `:Lazy sync` | Install missing + update + clean removed plugins |
| `:Lazy update` | Update all plugins (updates `lazy-lock.json`) |
| `:Lazy install` | Install any not-yet-installed plugins |
| `:Lazy clean` | Remove plugins no longer in the config |
| `:Lazy build <name>` | Re-run a plugin's build step (e.g. fzf-native) |
| `:Lazy restore` | Roll all plugins back to the versions in `lazy-lock.json` |
| `:Lazy profile` | See startup timing |

**To add a plugin:** create a new file in `lua/kresna/plugins/` returning a spec
table (copy an existing one), then run `:Lazy sync`.

> **fzf build issue?** If Telescope errors with `'fzf' extension doesn't exist`,
> run `:Lazy build telescope-fzf-native.nvim` (needs `make` + a C compiler).

---

## General keymaps

From `lua/kresna/basic/keymaps.lua`.

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>p` | Visual | Paste over selection **without** losing your yank |
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank whole line to system clipboard |
| `gl` | Normal | Show diagnostics for the line in a float |

**Window splits**

| Key | Action |
| --- | --- |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<C-w> h/j/k/l` | Move between windows |

**Tabs**

| Key | Action |
| --- | --- |
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tf` | Open current buffer in a new tab |

---

## Plugin guide

Each section lists **what it's for**, its **commands** (`:keywords`), its
**shortcuts**, and **how to use it**.

### Telescope — fuzzy finder

Fuzzy-find files, text, buffers, and help. Powered by `fzf-native` for speed.

**Shortcuts (from anywhere):**

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text in the project) |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |

**Inside a Telescope window** (default keys):

| Key | Action |
| --- | --- |
| `<C-n>` / `<C-p>` | Next / previous result |
| `<CR>` | Open selection |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-u>` / `<C-d>` | Scroll the preview up / down |
| `<Tab>` | Toggle-select (multi-select) |
| `<C-q>` | Send results to the quickfix list |
| `<Esc>` / `<C-c>` | Close |

**How to use:** press `<leader>ff`, start typing part of a filename, then `<CR>`.
For searching *content*, use `<leader>fg` and type the text you're looking for.

### nvim-tree — file explorer

A sidebar file tree (replaces netrw).

**Shortcuts (from anywhere):**

| Key | Action |
| --- | --- |
| `<leader>ef` | Focus the file explorer |
| `<leader>ee` | Toggle explorer on the current file |
| `<leader>ec` | Collapse the explorer |
| `<leader>er` | Refresh the explorer |

**Inside the tree** (default keys — press `g?` for the full list):

| Key | Action |
| --- | --- |
| `<CR>` / `o` | Open file / expand folder |
| `a` | Create file or folder (end with `/` for a folder) |
| `d` | Delete |
| `r` | Rename |
| `x` | Cut · `c` Copy · `p` Paste |
| `H` | Toggle hidden (dotfiles) |
| `R` | Refresh |
| `g?` | Help |

**How to use:** `<leader>ee` to open the tree focused on your current file,
navigate with `j`/`k`, `<CR>` to open, `a` to create new files.

### LSP (lsp-zero + Mason)

Code intelligence — go-to-definition, hover docs, rename, diagnostics. Servers
are installed through **Mason**.

**Set up a language server:**
1. Run `:Mason` to open the installer UI.
2. Find your language, press `i` to install (`X` to uninstall, `q` to quit).
3. Reopen a file of that type — the server attaches automatically.

`lua_ls` and `tsserver` (TypeScript) have custom setups baked in.

**Shortcuts (active when a server is attached):**

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
| `[d` / `]d` | Previous / next diagnostic |
| `gl` | Show line diagnostics in a float (custom) |

**Useful commands:** `:LspInfo` (see attached servers), `:LspRestart`, `:Mason`.

### nvim-cmp — autocompletion

The completion popup that appears as you type in insert mode.

| Key | Action |
| --- | --- |
| `<C-Space>` | Trigger the completion menu |
| `<CR>` | Confirm the selected item |
| `<C-u>` / `<C-d>` | Scroll the docs popup up / down |
| `<C-f>` | Jump to next snippet placeholder |
| `<C-b>` | Jump to previous snippet placeholder |

**How to use:** just type — suggestions appear. Use `<C-n>`/`<C-p>` (or arrows)
to move, `<CR>` to accept.

### Treesitter

Better syntax highlighting and code parsing. Mostly automatic — missing parsers
install themselves when you open a file (`auto_install` is on).

| Command | What it does |
| --- | --- |
| `:TSInstall <lang>` | Install a parser manually |
| `:TSUpdate` | Update all parsers |
| `:TSBufToggle highlight` | Toggle highlighting for the buffer |

Pre-installed: astro, vue, json, rust, javascript, go, typescript, toml, yaml, markdown.

### gitsigns — git in the gutter

Shows added/changed/removed lines in the sign column, plus **inline blame** on
the current line (author + date + summary appear automatically).

This config sets **no custom keys** for gitsigns — drive it with commands:

| Command | What it does |
| --- | --- |
| `:Gitsigns next_hunk` / `prev_hunk` | Jump between changes |
| `:Gitsigns preview_hunk` | Preview the change under the cursor |
| `:Gitsigns stage_hunk` | Stage the hunk |
| `:Gitsigns undo_stage_hunk` | Unstage the hunk |
| `:Gitsigns reset_hunk` | Discard the hunk |
| `:Gitsigns blame_line` | Full blame popup for the line |
| `:Gitsigns toggle_current_line_blame` | Turn inline blame on/off |
| `:Gitsigns diffthis` | Diff the file against the index |

### diffview — diffs & merge conflicts

A full-tab view for git diffs and resolving merge conflicts.

| Command | What it does |
| --- | --- |
| `:DiffviewOpen` | Diff the working tree vs HEAD |
| `:DiffviewOpen main..HEAD` | Diff a range of commits |
| `:DiffviewFileHistory` | Browse a file's git history |
| `:DiffviewFileHistory %` | History of the current file |
| `:DiffviewClose` | Close the view |

**Inside the view:**

| Key | Action |
| --- | --- |
| `<Tab>` / `<S-Tab>` | Next / previous changed file |
| `<leader>e` | Focus the file panel |
| `<leader>b` | Toggle the file panel |
| `gf` | Open the real file |
| `[x` / `]x` | Jump between conflicts |

**Resolving a merge conflict** (custom keys):

| Key | Take… |
| --- | --- |
| `<leader>co` | **ours** (current branch) for this conflict |
| `<leader>ct` | **theirs** (incoming) for this conflict |
| `<leader>cb` | **base** (common ancestor) |
| `<leader>ca` | **all** versions stacked |
| `<leader>cO` | ours for the **whole file** |
| `dx` | delete the conflict region |

**How to use:** during a merge with conflicts, run `:DiffviewOpen`, walk files
with `<Tab>`, jump conflicts with `]x`, pick a side with `<leader>co`/`<leader>ct`,
then save and `:DiffviewClose`.

### toggleterm — terminal

An integrated terminal.

| Key | Mode | Action |
| --- | --- | --- |
| `<C-\>` | Normal / Terminal | Toggle the terminal |
| `<Esc>` or `jk` | Terminal | Leave insert (to normal mode) |
| `<C-h/j/k/l>` | Terminal | Move to the window left/down/up/right |

**Commands:** `:ToggleTerm`, `:ToggleTerm direction=float`,
`:ToggleTerm direction=vertical`, `:TermExec cmd="npm test"`.

**How to use:** `<C-\>` opens a horizontal terminal at the bottom. Prefix with a
count to open numbered terminals — e.g. `2<C-\>` opens/toggles terminal #2.

### flatten — open files from terminal

When you run `nvim <file>` from *inside* the toggleterm terminal, it opens the
file in your **existing** Neovim instead of nesting a new one. No keys needed —
it just works. Great for `git commit` opening its message in the current editor.

### bufferline — tab line

The bar of tabs across the top. It's in **tabs mode**, so it follows Neovim's
native tabs — manage them with the tab keymaps from
[General keymaps](#tabs) (`<leader>to`, `<leader>tn`, `<leader>tp`, `<leader>tx`).

### markdown-preview

Live preview of a Markdown file in your **browser**, updating as you type.

| Key | Action |
| --- | --- |
| `<leader>mp` | Toggle the browser preview (in a markdown file) |

| Command | What it does |
| --- | --- |
| `:MarkdownPreview` | Start the preview |
| `:MarkdownPreviewStop` | Stop it |
| `:MarkdownPreviewToggle` | Toggle it |

**How to use:** open any `.md` file and press `<leader>mp` — your browser opens
with the rendered preview and scrolls in sync. The preview closes automatically
when you leave the buffer.

### ChatGPT

Ask ChatGPT from inside Neovim. **Requires `OPENAI_API_KEY`** in your environment.

All under the `<leader>c` prefix (works on a visual selection too):

| Key | Action |
| --- | --- |
| `<leader>cc` | Open ChatGPT |
| `<leader>ce` | Edit with instruction |
| `<leader>cg` | Grammar correction |
| `<leader>ct` | Translate |
| `<leader>ck` | Keywords |
| `<leader>cd` | Docstring |
| `<leader>ca` | Add tests |
| `<leader>co` | Optimize code |
| `<leader>cs` | Summarize |
| `<leader>cf` | Fix bugs |
| `<leader>cx` | Explain code |
| `<leader>cr` | Roxygen edit |
| `<leader>cl` | Code readability analysis |

**How to use:** select some code in visual mode, then e.g. `<leader>cx` to have
it explained, or `<leader>cf` to get a bug fix.

### rust-tools — Rust

Enhances rust-analyzer with inlay hints (types shown inline) and hover actions.
Loads automatically for Rust files. Needs `rust-analyzer` (install via `:Mason`
or rustup).

| Command | What it does |
| --- | --- |
| `:RustHoverActions` | Hover with runnable actions |
| `:RustRunnables` | Pick something to run |
| `:RustDebuggables` | Pick something to debug |
| `:RustExpandMacro` | Expand the macro under the cursor |
| `:RustOpenCargo` | Open `Cargo.toml` |
| `:RustReloadWorkspace` | Reload rust-analyzer |
| `:RustSetInlayHints` / `:RustDisableInlayHints` | Toggle type hints |

Standard LSP keys ([above](#lsp-lsp-zero--mason)) also work in Rust files.

### go.nvim — Go

Go tooling. **`goimports` runs automatically on save** (formats + fixes imports).
Loads for `.go`/`go.mod` files.

**First-time setup:** run `:GoInstallBinaries` once to install the Go tools.

| Command | What it does |
| --- | --- |
| `:GoFmt` / `:GoImport` | Format / fix imports manually |
| `:GoRun` / `:GoBuild` | Run / build |
| `:GoTest` / `:GoTestFunc` | Run tests / just the test under cursor |
| `:GoCoverage` | Show test coverage |
| `:GoIfErr` | Insert an `if err != nil` block |
| `:GoFillStruct` | Fill a struct literal with fields |
| `:GoAddTag` / `:GoRmTag` | Add / remove struct tags |
| `:GoDoc` | Show docs for the symbol |

Standard LSP keys ([above](#lsp-lsp-zero--mason)) also work in Go files.

### which-key

Forgot a shortcut? Press **`<leader>`** (or any prefix like `g`) and **wait ~0.9s**
— a popup lists every key you can press next and what it does. This is the
in-editor version of this README. No setup needed.

### Passive plugins (no keys needed)

| Plugin | What it does |
| --- | --- |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-closes brackets/quotes as you type |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | The statusline (mode, branch, diagnostics, position) — dracula theme |
| [rose-pine](https://github.com/rose-pine/neovim) | The colorscheme (moon variant). Change with `:colorscheme <name>` |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File-type icons used by the tree, bufferline, and statusline |

---

## Notes

- Deprecation warnings from pinned plugins are silenced at the top of `init.lua`
  (`vim.deprecate = function() end`). Run `:checkhealth vim.deprecated` any time
  to see what's actually deprecated.
- `neo-tree.lua_disable` and `typescript-tools.lua_disable` are disabled specs —
  rename them back to `.lua` to re-enable.
- Health check for the whole setup: `:checkhealth`.
