# Neovim Config (kresna)

A [lazy.nvim](https://github.com/folke/lazy.nvim)-managed Neovim setup with LSP
(via lsp-zero), fuzzy finding (Telescope + fzf-native), Git integration, a
terminal, Rust/Go tooling, and Markdown preview.

> **This README is your cheat sheet.** Whenever you forget how a plugin works,
> come back here — every plugin has its commands, shortcuts, and a short
> "how to use" below.

**Leader key:** `<Space>` (written as `<leader>`)

### How to read the shortcuts

The keys use Vim's notation. `<...>` is one special key; **`C-` means Ctrl**,
`S-` means Shift.

| Notation | Means | Example |
| --- | --- | --- |
| `<leader>` | The **Space** bar | `<leader>ff` = Space, then `f`, then `f` |
| `<C-o>` | **Ctrl + o** (hold Ctrl, press `o`) | `<C-o>` = Ctrl+O |
| `<C-\>` | **Ctrl + \\** | toggles the terminal |
| `<S-Tab>` | **Shift + Tab** | |
| `<CR>` | **Enter** (carriage return) | |
| `<Esc>` | **Escape** | |
| `<F2>` … `<F4>` | The **function keys** F2–F4 | |
| `gd`, `jk` | Plain letters — press them **in sequence**, not together | `gd` = `g` then `d` |

So `<C-h/j/k/l>` means "Ctrl + h, Ctrl + j, Ctrl + k, or Ctrl + l", and
`<leader>co` means "Space, then `c`, then `o`".

## ⚡ Shortcut cheat sheet

Quick reference for the custom keys in this config (`<leader>` = **Space**).
Scan it daily to build muscle memory; jump to the [Plugin guide](#plugin-guide)
for the full details and in-plugin keys.

| Shortcut | Does | | Shortcut | Does |
| --- | --- | --- | --- | --- |
| **Find & files** | | | **Window & tabs** | |
| `<leader>ff` | Find files | | `<leader>sv` | Split vertical |
| `<leader>fg` | Live grep (search text) | | `<leader>sh` | Split horizontal |
| `<leader>fb` | Open buffers | | `<leader>se` | Equalize splits |
| `<leader>fh` | Help tags | | `<leader>sx` | Close split |
| `<leader>ee` | Toggle file tree | | `<C-w> h/j/k/l` | Move between windows |
| `<leader>ef` | Focus file tree | | `<leader>to` | New tab |
| `<leader>ec` | Collapse tree | | `<leader>tn` / `tp` | Next / prev tab |
| `<leader>er` | Refresh tree | | `<leader>tx` | Close tab |
| **LSP (code)** | | | **Clipboard** | |
| `K` | Hover docs | | `<leader>y` / `Y` | Yank to system clipboard |
| `gd` / `gD` | Definition / declaration | | `<leader>p` | Paste, keep register (visual) |
| `gi` / `go` | Implementation / type | | **Terminal** | |
| `gr` | References | | `<C-\>` | Toggle terminal |
| `gs` | Signature help | | `<Esc>` / `jk` | Leave terminal mode |
| `<F2>` | Rename | | `<C-h/j/k/l>` | Move out of terminal |
| `<F3>` / `<F4>` | Format / code action | | **Markdown** | |
| `[d` / `]d` | Prev / next diagnostic | | `<leader>mp` | Toggle browser preview |
| `gl` | Line diagnostics float | | **Discover keys** | |
| **Completion** (insert) | | | `<leader>` + wait | which-key popup |
| `<C-Space>` | Trigger menu | | `:Lazy` | Manage plugins |
| `<CR>` | Confirm item | | `:Mason` | Install LSP servers |
| `<C-f>` / `<C-b>` | Next / prev snippet stop | | `:checkhealth` | Diagnose the setup |
| | | | **Git** | |
| | | | `<leader>gg` | lazygit dashboard |
| | | | `<leader>gf` | lazygit (current file's repo) |
| | | | **Edit & move** | |
| | | | `s` + chars | Flash jump anywhere |
| | | | `ysiw)` `cs"'` `ds(` | Surround add/change/delete |
| | | | `daf` / `vif` | Delete / select a function |
| | | | `]m` / `[m` | Next / prev function |
| | | | `<leader>xx` | Diagnostics panel (Trouble) |
| | | | `<leader>ft` · `]t` | Find TODOs · next TODO |

**Merge conflicts** (in `:DiffviewOpen`): `<leader>co` take ours · `<leader>ct`
take theirs · `<leader>cb` base · `<leader>ca` all · `dx` delete region ·
`]x` / `[x` next / prev conflict.

### 🧭 Code Navigation

Jump around code — functions, variables, constants, types. Put the cursor on a
symbol and press the key. **Powered by the LSP server**, so the relevant server
must be installed via `:Mason` (check with `:LspInfo` if a key does nothing).

| Key | Jumps to | Notes |
| --- | --- | --- |
| `gd` | **Definition** | The everyday one — funcs, vars, consts, types |
| `gD` | **Declaration** | Often same as `gd`; distinct mainly in C/C++ headers |
| `gi` | **Implementation** | Implementers of an interface/abstract method (e.g. Go interfaces) |
| `go` | **Type definition** | The type of the variable/constant under the cursor |
| `gr` | **References** | Every place the symbol is used |
| `K` | **Hover docs** | Signature + docs without leaving the spot |
| `<C-o>` | **Jump back** | Return to where you jumped from |
| `<C-i>` | **Jump forward** | Redo a jump (opposite of `<C-o>`) |

**Go to definition — even in another file.** Put the cursor on a function or
variable and press **`gd`**. If its definition lives in a *different* file,
Neovim **opens that file automatically** and jumps to the exact line. Works the
same whether the definition is in the same file or across the project.

**Go back — one or several jumps.** Each jump is remembered in the **jumplist**,
so you can retrace your steps:

```
gd        jump to the definition (opens the related file)
gd        follow another symbol from there (opens yet another file)
<C-o>     go back one step  (returns to the previous location)
<C-o>     go back again     (press it as many times as you jumped)
<C-o>     …keep going back through the whole trail
<C-i>     go forward again  (undo a <C-o>, i.e. re-follow the trail)
```

So to return to where you started after digging several files deep, just press
**`<C-o>` repeatedly** — once per jump you made. `<C-i>` (Ctrl+I, same as `Tab`)
walks forward again. Run **`:jumps`** to see the full list, or `3<C-o>` to jump
back 3 entries at once.

> Tip: `<C-o>` / `<C-i>` work for *any* jump, not just `gd` — searches (`/`),
> `G`, `gg`, `]m`, etc. all feed the same jumplist.

**Also handy:** `gr` lists everywhere a symbol is used, `gi` finds what
implements an interface, `K` shows its docs without moving.

## Table of contents

- [Structure](#structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Managing plugins (lazy.nvim)](#managing-plugins-lazynvim)
- [General keymaps](#general-keymaps)
- [Plugin guide](#plugin-guide) — commands, shortcuts & how-to for every plugin
  - [Telescope — fuzzy finder](#telescope--fuzzy-finder)
  - [nvim-tree — file explorer](#nvim-tree--file-explorer)
  - [LSP (lsp-zero + Mason)](#lsp-lsp-zero--mason)
  - [nvim-cmp — autocompletion](#nvim-cmp--autocompletion)
  - [Treesitter](#treesitter)
  - [lazygit — git dashboard](#lazygit--git-dashboard)
  - [gitsigns — git in the gutter](#gitsigns--git-in-the-gutter)
  - [diffview — diffs & merge conflicts](#diffview--diffs--merge-conflicts)
  - [toggleterm — terminal](#toggleterm--terminal)
  - [flatten — open files from terminal](#flatten--open-files-from-terminal)
  - [bufferline — tab line](#bufferline--tab-line)
  - [markdown-preview](#markdown-preview)
  - [rust-tools — Rust](#rust-tools--rust)
  - [go.nvim — Go](#gonvim--go)
  - [which-key](#which-key)
  - [nvim-surround — surround text](#nvim-surround--surround-text)
  - [flash.nvim — jump anywhere](#flashnvim--jump-anywhere)
  - [trouble.nvim — diagnostics panel](#troublenvim--diagnostics--references-panel)
  - [todo-comments — track TODO/FIXME](#todo-commentsnvim--track-todofixme)
  - [Treesitter text objects](#treesitter-text-objects)
  - [Passive plugins](#passive-plugins-no-keys-needed)
- [Tips & tricks (coming from VS Code)](#-tips--tricks-coming-from-vs-code)

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
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) (`rg`) — powers Telescope's find-in-files
- [`lazygit`](https://github.com/jesseduffield/lazygit) — the git dashboard (`<leader>gg`)
- `node` — for markdown-preview (the binary is auto-downloaded on install)
- A [Nerd Font](https://www.nerdfonts.com/) **set as your terminal font** — for
  icons in the tree, statusline, bufferline (see [Installation step 4](#4-set-your-terminal-to-use-the-nerd-font))
- A true-color terminal (iTerm2, WezTerm, Kitty, …) — `termguicolors` is on
- Language servers install on demand via **Mason** (`:Mason`)

---

## Installation

This is a full Neovim config — it lives in `~/.config/nvim`.

### 1. Back up any existing config

If you already have a Neovim setup, move it aside first (skip if this is a fresh machine):

```bash
mv ~/.config/nvim ~/.config/nvim.bak
# optional: also clear old plugin/cache data for a clean slate
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone this repo

```bash
# SSH (if your GitHub SSH key is set up)
git clone git@github.com:slaveofcode/my-nvim-config.git ~/.config/nvim

# or HTTPS
git clone https://github.com/slaveofcode/my-nvim-config.git ~/.config/nvim
```

### 3. Install the prerequisites

Make sure the tools from [Requirements](#requirements) are present. On macOS with Homebrew:

```bash
brew install neovim git make fzf ripgrep lazygit node
# then install a Nerd Font, e.g.:
brew install --cask font-jetbrains-mono-nerd-font
```

### 4. Set your terminal to use the Nerd Font

**This step is required for the file-tree, statusline, and git icons to render.**
Installing the font isn't enough — the terminal must be told to *use* it, or every
icon shows as a `?`-in-a-box (missing glyph).

<details>
<summary><b>Ghostty</b> (this setup's terminal)</summary>

Edit `~/.config/ghostty/config` (create it if missing) and add:

```
font-family = "JetBrainsMono Nerd Font Mono"
font-size = 14
```

Then reload: **`Cmd+Shift+,`**, or quit and reopen Ghostty.
Check the exact installed name with `ghostty +list-fonts | grep -i jetbrains`.
</details>

<details>
<summary><b>iTerm2</b></summary>

Settings → Profiles → Text → Font → pick **JetBrainsMono Nerd Font**.
</details>

<details>
<summary><b>WezTerm</b></summary>

In `~/.wezterm.lua`:

```lua
config.font = wezterm.font("JetBrainsMono Nerd Font")
```
</details>

<details>
<summary><b>Kitty</b></summary>

In `~/.config/kitty/kitty.conf`:

```
font_family JetBrainsMono Nerd Font Mono
```
</details>

> Sanity check: run `echo -e "  "` in the terminal. If you see
> icons (not boxes), the font is working.

### 5. First launch

```bash
nvim
```

On first start, **lazy.nvim bootstraps itself and installs every plugin
automatically**. Let it finish, then **quit and reopen** so all plugins load
cleanly. During this first run:

- `telescope-fzf-native` compiles its native library (needs `make` + a C compiler).
- Treesitter parsers build automatically (`:TSUpdate` runs on install).
- `markdown-preview` downloads its preview binary.

### 6. Install language servers

Open Neovim and run `:Mason`, then install the servers you want (press `i` on
each). `lua_ls` and `tsserver` already have custom setups baked in.

### 7. Verify

```vim
:checkhealth
```

Fix anything flagged as an error (warnings are usually fine). You're done — see
the [Plugin guide](#plugin-guide) for how to use everything.

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
| `<C-t>` | Open the file in a **new tab** |
| `<C-v>` | Open in a **vertical** split |
| `<C-x>` | Open in a **horizontal** split |
| `a` | Create file or folder (end with `/` for a folder) |
| `d` | Delete |
| `r` | Rename |
| `x` | Cut · `c` Copy · `p` Paste |
| `H` | Toggle hidden (dotfiles) |
| `R` | Refresh |
| `g?` | Help |

**How to use:** `<leader>ee` to open the tree focused on your current file,
navigate with `j`/`k`, `<CR>` to open, `a` to create new files.

**Open several files in tabs from the sidebar & switch between them.**
The tabs appear along the top bar (bufferline, in tabs mode).

1. Open the tree (`<leader>ee`) and move to a file with `j`/`k`.
2. Press **`<C-t>`** to open it in a **new tab**. The tree stays open.
3. Move to another file and press `<C-t>` again — repeat for as many tabs as you want.
4. **Switch between tabs:**

| Key | Action |
| --- | --- |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `gt` / `gT` | Next / previous tab (built-in) |
| `1gt`, `2gt`, … | Jump straight to tab **N** |
| `<leader>tx` | Close the current tab |
| `<leader>to` | Open a new empty tab |

You can also click a tab in the top bar. See [bufferline](#bufferline--tab-line)
and the [tab keymaps](#tabs).

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

### lazygit — git dashboard

A full-screen, keyboard-driven git UI (the standalone `lazygit` TUI, opened in a
float). The quickest way to stage, commit, push, branch, rebase, stash, and
browse history — the closest thing to a git GUI.

| Key | Action |
| --- | --- |
| `<leader>gg` | Open lazygit for the project |
| `<leader>gf` | Open lazygit for the current file's repo |

| Command | Does |
| --- | --- |
| `:LazyGit` | Open the dashboard |
| `:LazyGitCurrentFile` | Open it scoped to the current file's repo |
| `:LazyGitFilter` | Browse commits (project) |

**Inside lazygit** (the essentials — press `?` for the full list):

| Key | Action |
| --- | --- |
| `<Tab>` | Move between panels (Files / Branches / Commits / Stash) |
| `Space` | Stage / unstage the file or hunk under the cursor |
| `c` | Commit (opens a message box; type it, confirm) |
| `P` / `p` | Push / pull |
| `b` | Branch menu (checkout/create) |
| `<Enter>` | Drill into a file to stage individual lines/hunks |
| `q` | Quit back to Neovim |

**How to use:** `<leader>gg`, press `Space` on the files you want, `c` to commit,
`P` to push, `q` to exit. Requires the `lazygit` binary (`brew install lazygit`).

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

An integrated terminal that **floats** over the editor.

| Key | Mode | Action |
| --- | --- | --- |
| `<C-\>` | Normal / Terminal | Toggle the terminal (floating) |
| `<Esc>` or `jk` | Terminal | Leave insert (to normal mode) |
| `<C-h/j/k/l>` | Terminal | Move to the window left/down/up/right |

**Commands:** `:ToggleTerm`, `:ToggleTerm direction=horizontal`,
`:ToggleTerm direction=vertical`, `:TermExec cmd="npm test"`.

**How to use:** `<C-\>` opens a floating terminal over the current tab. Prefix
with a count to open numbered terminals — e.g. `2<C-\>` opens/toggles terminal #2.

**Shared across tabs.** The terminal is a **float**, so it isn't tied to any one
tab's window layout. Open it in one tab, switch to another, press `<C-\>` — the
**same** terminal (same shell, same running command) appears over the new tab.
Your process keeps running the whole time; switching tabs just hides the float.

> Why not a bottom split? A horizontal/vertical terminal is a window *inside* one
> tab, so it vanishes when you switch tabs and `<C-\>` there won't pull it over.
> The float avoids that. You can still get a bottom one anytime with
> `:ToggleTerm direction=horizontal`.

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

### nvim-surround — surround text

Add, change, or delete the characters *around* text (quotes, brackets, tags).

| Shortcut | Action | Example |
| --- | --- | --- |
| `ys{motion}{char}` | Add surround | `ysiw)` → wrap word in `()` |
| `cs{old}{new}` | Change surround | `cs"'` → `"hi"` becomes `'hi'` |
| `ds{char}` | Delete surround | `ds(` → remove parentheses |
| `S{char}` (visual) | Surround selection | select, `S]` → wrap in `[]` |

Mnemonics: **y**ank-**s**urround (add), **c**hange-**s**urround, **d**elete-**s**urround.

### flash.nvim — jump anywhere

Jump to any spot on screen in a few keystrokes instead of counting lines.

| Key | Action |
| --- | --- |
| `s` | Type `s` then 1–2 chars of your target → labels appear, press the label to jump |
| `S` | Jump by treesitter node (structural select) |
| `r` (in operator) | Remote flash — e.g. `yr` then jump to yank a distant text object |

Works in normal, visual, and operator-pending mode (so `ds` + `s`-jump composes).

### trouble.nvim — diagnostics / references panel

A tidy panel listing all diagnostics, references, or quickfix entries so you can
step through them instead of one floating window at a time. All under `<leader>x`:

| Key | Opens |
| --- | --- |
| `<leader>xx` | All diagnostics (project) |
| `<leader>xX` | Diagnostics for the current buffer only |
| `<leader>xr` | LSP references / definitions |
| `<leader>xs` | Document symbols outline |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `<leader>xt` | TODO comments (see below) |

Inside the panel: `j`/`k` to move, `<CR>` to jump to the item, `q` to close.

### todo-comments.nvim — track TODO/FIXME

Highlights comment tags like `TODO:`, `FIXME:`, `HACK:`, `NOTE:` and lets you
find and jump between them.

| Key | Action |
| --- | --- |
| `<leader>ft` | Search all TODOs (Telescope) |
| `<leader>xt` | List all TODOs in the Trouble panel |
| `]t` / `[t` | Jump to next / previous TODO comment |

### Treesitter text objects

Select and move by code structure — functions, classes, parameters (part of the
[Treesitter](#treesitter) setup).

| Key | Selects / moves to |
| --- | --- |
| `af` / `if` | A **f**unction (outer / inner) — e.g. `vaf`, `daf`, `cif` |
| `ac` / `ic` | A **c**lass (outer / inner) |
| `aa` / `ia` | A parameter/**a**rgument (outer / inner) |
| `]m` / `[m` | Next / previous function start |
| `]]` / `[[` | Next / previous class start |

Combine with any operator: `daf` delete a function, `vif` select a function body,
`cia` change an argument.

### Passive plugins (no keys needed)

| Plugin | What it does |
| --- | --- |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-closes brackets/quotes as you type |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | The statusline (mode, branch, diagnostics, position) — dracula theme |
| [rose-pine](https://github.com/rose-pine/neovim) | The colorscheme (moon variant). Change with `:colorscheme <name>` |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File-type icons used by the tree, bufferline, and statusline |

---

## 💡 Tips & tricks (coming from VS Code)

The everyday "how do I do *that* here?" list. `<leader>` = **Space**.

### Coming-from-VS-Code quick map

| In VS Code | Here | Notes |
| --- | --- | --- |
| `Cmd+P` open file | `<leader>ff` | Fuzzy find files |
| `Cmd+Shift+F` find in files | `<leader>fg` | Search text everywhere (ripgrep) |
| `F2` rename symbol | `<F2>` | Renames **all usages** (see below) |
| `Cmd+H` replace in file | `:%s/old/new/g` | Substitute (see below) |
| `Cmd+/` toggle comment | `gcc` (line) / `gc` (selection) | Built-in |
| `Cmd+D` multi-cursor | `<C-v>` block, or `cgn`+`.` | See "edit many lines" |
| `Ctrl+G` go to line | `:42` then `Enter` | Or `42G` |
| `Cmd+A` select all | `ggVG` | |
| Alt+↑/↓ move line | `:m` command / `ddp` | See below |
| `Cmd+Z` / `Cmd+Shift+Z` | `u` / `<C-r>` | Undo / redo |
| `Cmd+click` go to def | `gd` | See [Code Navigation](#-code-navigation) |
| Go back / forward | `<C-o>` / `<C-i>` | After any jump |

### Rename a symbol everywhere (variable, function, class, module…)

Put the cursor on the name and press **`<F2>`**, type the new name, `Enter`.
This is a **semantic** rename via the language server — it updates the
definition **and every usage/reference across the project**, not just matching
text. Works for variables, functions, methods, classes, types, modules, etc.

- Requires the language server for that file (install via `:Mason`, check `:LspInfo`).
- Preview affected spots first with **`gr`** (list references).
- Different from `:%s` below, which is dumb text replacement (no scope awareness).

### Edit many lines at once (the "multi-cursor" replacements)

Vim has three idioms that cover what multi-cursor does in VS Code:

**1. Visual block — same edit on a column of lines**
```
<C-v>          start block select
j j j …        extend down over the lines
I  (or A)      insert before (or append after) — type your text
<Esc>          the text appears on ALL selected lines
```
Use `I`/`A` to add a prefix/suffix to many lines, or `c` to change a block,
`d` to delete a column.

**2. Change next match, then repeat — like `Cmd+D`**
```
*              search for the word under the cursor
cgn            change the next match (type the replacement)
<Esc>          then press .  to repeat on the next match, . again, …
```
`n` skips a match you don't want to change; `.` applies your change to the next one.

**3. Substitute across the file — change all at once**
```
:%s/old/new/g     replace every "old" with "new" in the file
:%s/old/new/gc    …with a confirm prompt for each (y/n/a/q)
```

### Find & replace in the current file (`:s`)

| Command | Does |
| --- | --- |
| `:%s/foo/bar/g` | Replace all `foo` → `bar` in the file |
| `:%s/foo/bar/gc` | …asking to confirm each one |
| `:s/foo/bar/g` | Only on the current line |
| `:'<,'>s/foo/bar/g` | Only in the visual selection (select first, then `:s…`) |
| `:%s/\<foo\>/bar/g` | Whole word only (`\<` `\>` are word boundaries) |
| `:%s/foo/bar/gi` | Case-**insensitive** match |
| `:%s/foo/bar/gI` | Force case-**sensitive** |

Special characters in the pattern (`. * / \ [ ]`…) must be escaped with `\`,
e.g. replace `a.b()` → `:%s/a\.b()/x/g`. Escape a literal `/` as `\/`, or use a
different delimiter: `:%s#path/one#path/two#g`.

### Find text across files & subdirectories

Press **`<leader>fg`** (Telescope live grep, powered by ripgrep). It searches the
whole project recursively (respecting `.gitignore`).

- **Case sensitivity — smart by default:** an all-lowercase query is
  case-**insensitive**; include any uppercase letter and it becomes
  case-**sensitive**. To force it inline, prefix the regex:
  `(?i)error` = always case-insensitive, `(?-i)Error` = always case-sensitive.
- **The query is a regex.** A space matches a literal space, so
  `foo bar` finds "foo bar". Metacharacters are special — to search a literal
  `config.get(` escape them: `config\.get\(` — or match loosely with `.`.
- **Then narrow:** after results appear, keep typing to refine, `<C-n>`/`<C-p>`
  to move, `<CR>` to open, `<C-v>`/`<C-x>` to open in a split. `<C-q>` dumps all
  matches into the quickfix list to step through with `:cnext` / `:cprev`.
- **Search only a subfolder:** run
  `:lua require('telescope.builtin').live_grep({ search_dirs = { 'app/', 'lib/' } })`.
- **Find the word under the cursor across files:** see `grep_string` —
  `:lua require('telescope.builtin').grep_string()` (treats it as literal text).

#### Example — find a variable name in any directory

Say you're looking for `userId` across the whole project. Press `<leader>fg`, then type:

| You type | Finds | Case |
| --- | --- | --- |
| `userId` | `userId` (uppercase present → exact case) | **sensitive** |
| `userid` | `userId`, `userid`, `USERID`, `UserId`… | **insensitive** (all-lowercase = smart-case) |
| `(?i)userId` | same as above, forced | **insensitive** (explicit) |
| `(?-i)userid` | only literal `userid` | **sensitive** (explicit) |
| `\buserId\b` | `userId` but **not** `userIdList` or `myUserId` | whole word only |

So the rule of thumb: **type it all-lowercase to ignore case, or include a capital
(or use `(?-i)`) to match case exactly.** Wrap it in `\b…\b` when you want the
whole identifier and not substrings. It searches every subdirectory by default
(honoring `.gitignore`); to limit it to some folders, use the `search_dirs` form
above. `<CR>` opens a hit; `<C-q>` sends them all to the quickfix list.

### Working with Git (diffs, blame, history)

The **fastest way to do anything git** is **lazygit** — press **`<leader>gg`**
for a full git dashboard (stage, commit, push/pull, branch, rebase, stash, view
diffs & log). See [lazygit](#lazygit--git-dashboard). The two plugins below add
the in-editor view: **gitsigns** (in the file you're editing) and **diffview**
(full-screen diffs & history). The branch + `+/-` change counts also show in the
statusline (lualine).

**See what changed — in the current file (gitsigns).**
Changed lines are marked in the gutter (`│` add/change, `_` delete). Then:

| Command | Does |
| --- | --- |
| `:Gitsigns preview_hunk` | Pop up the **diff** of the change under the cursor |
| `:Gitsigns next_hunk` / `prev_hunk` | Jump to the next / previous change |
| `:Gitsigns blame_line` | Who last changed this line (full commit popup) |
| `:Gitsigns diffthis` | Split-diff the file vs the index (staged version) |
| `:Gitsigns stage_hunk` / `undo_stage_hunk` | Stage / unstage just this hunk |
| `:Gitsigns reset_hunk` | Discard this hunk's changes |
| `:Gitsigns toggle_current_line_blame` | Turn the inline blame (author · date) on/off |

Inline blame is **on by default** — the author and summary of the current line
show faded at the end of the line.

**See the full diff / history (diffview).**

| Command | Does |
| --- | --- |
| `:DiffviewOpen` | Side-by-side diff of **all** uncommitted changes vs HEAD |
| `:DiffviewOpen HEAD~2` | Diff the working tree against 2 commits back |
| `:DiffviewOpen main..HEAD` | Diff your branch against `main` |
| `:DiffviewFileHistory %` | **History of the current file** — walk every commit that touched it |
| `:DiffviewFileHistory` | History of the whole repo |
| `:DiffviewClose` | Close the diff view |

Inside it: `<Tab>` / `<S-Tab>` move between files, `<CR>` opens a file's diff,
`<leader>e` toggles the file panel. See [diffview](#diffview--diffs--merge-conflicts).

**Commit, push, branch, etc.** Easiest is **`<leader>gg`** (lazygit) — stage with
`Space`, commit with `c`, push with `P`, quit with `q`. Or open the terminal with
`<C-\>` and run git normally (`git add -p`, `git commit`, `git push`…); when
`git commit` opens its message editor, **flatten.nvim** opens it in your current
Neovim — write the message and `:wq` to finish (`:q!` to abort). See
[Quitting Vim](#quitting-vim--the-editor-opened-inside-the-terminal-trap).

### Jump to a file that has a git conflict

After a `git merge`/`git rebase`/`git pull` leaves conflicts, here are the ways
to find and open the conflicted files:

- **Best — open Diffview:** `:DiffviewOpen`. During a merge it lists the
  conflicted files in the left panel (a "Conflicts" group). Move between them
  with `<Tab>` / `<S-Tab>`, jump between conflict hunks with `]x` / `[x`, and
  resolve with `<leader>co` (ours) / `<leader>ct` (theirs) — see
  [diffview](#diffview--diffs--merge-conflicts).
- **See all changed/unmerged files:** `:lua require('telescope.builtin').git_status()`
  — conflicted files show as unmerged (`UU`); press `<CR>` to open one.
- **Search for the conflict markers:** `<leader>fg` then type `<<<<<<<`
  (the merge marker). Every hit is a conflict location across the project — open
  one with `<CR>`, or `<C-q>` to send them all to the quickfix list and step
  through with `:cnext` / `:cprev`.
- **Inside a conflicted file:** the markers are `<<<<<<<`, `=======`, `>>>>>>>`.
  Search to the next one with `/<<<<<<<` then `Enter` (or `n` to repeat).

### Reload a file changed by git pull (or edited outside nvim)

When `git pull` (or another tool) changes a file you already have open, Neovim
keeps showing the **old** version until you reload it from disk.

| Command | Does |
| --- | --- |
| `:e` | Reload the **current** file from disk |
| `:e!` | Force reload, **discarding** your unsaved edits |
| `:checktime` | Reload **all** open buffers that changed on disk (keeps ones you've edited) |
| `<leader>er` | Refresh the nvim-tree sidebar (show new / deleted files) |

**Typical flow after a pull:** `:e` in the open file (or `:checktime` if several
are open across tabs). Gitsigns updates the gutter automatically.

> `autoread` is on, but nothing auto-triggers it in this config, so reload
> manually with `:e` / `:checktime`. (Ask if you want it to reload automatically
> when you switch back to Neovim.)

### Handy one-liners

| Task | How |
| --- | --- |
| Go to line 120 | `:120` then `Enter` (or `120G`) |
| Top / bottom of file | `gg` / `G` |
| Copy whole file to clipboard | `ggVGy` (clipboard is the default register) |
| Copy current file's path | `:let @+ = expand('%')` |
| Select all | `ggVG` |
| Indent / outdent selection | select, then `>` / `<` (repeat with `.`) |
| Move a line down / up | `:m +1` / `:m -2` (or `ddp` / `ddkP`) |
| Delete without touching clipboard | `"_d` (e.g. `"_dd`) |
| Clear last search highlight | `:noh` |
| Reopen last closed file | `<leader>fb` or `:e#` |
| Save / quit | `:w` / `:q` (`:wq` both, `:q!` discard) |

> **Clipboard note:** this config sets `clipboard=unnamedplus`, so plain `y`
> (yank) and `p` (paste) already use your **system clipboard** — no need for a
> special register. `<leader>y` is just an explicit alias.

### Closing tabs, splits & windows

Handy distinction: a **split** is a window pane in the current tab; a **tab** is a
whole separate layout of windows. Closing one doesn't quit Neovim (unless it's
the very last window).

**Close a tab**

| Key / command | Does |
| --- | --- |
| `<leader>tx` | Close the **current tab** |
| `:tabclose` | Same as above |
| `:tabonly` | Close **all other** tabs (keep the current one) |

**Close a split / window**

| Key / command | Does |
| --- | --- |
| `<leader>sx` | Close the **current split** |
| `<C-w>c` | Close the current window (built-in) |
| `<C-w>o` | Close **all other** windows (keep only the current) |
| `:q` | Close the current window (quits Neovim if it's the last one) |

**Close the file explorer**

| Key | Does |
| --- | --- |
| `<leader>ee` | Toggle the tree off (and on) |
| `<leader>ec` | Collapse the tree |

> A split shows the *same or another buffer* — closing it doesn't delete the
> file or the buffer. To also drop the buffer from memory, use `:bd`.

### Quitting Vim & the "editor opened inside the terminal" trap

**How to quit at all** (do this from **normal** mode — press `<Esc>` first if you're typing):

| Command | Does |
| --- | --- |
| `:w` | Save |
| `:q` | Quit this window |
| `:wq` or `ZZ` | Save **and** quit |
| `:q!` or `ZQ` | Quit and **throw away** changes |
| `:qa` | Quit **all** windows/tabs |
| `:qa!` | Quit everything, discard all changes |

**The `git commit` (editor-inside-the-terminal) trap.** You opened the terminal
(`<C-\>`), ran `git commit`, and its message editor appeared. There are **two
situations** and the escape is different — pressing `:q` in the wrong one just
closes the toggleterm window (the trap!).

**First, tell which one you're in — look at the statusline:**

- If it shows **`COMMIT_EDITMSG`** → flatten opened it as a normal buffer
  (Situation A).
- If it shows **`…#toggleterm#…`** (like `zsh;#toggleterm#1`) → a **nested nvim**
  is running *inside* the terminal, and you've escaped to the outer nvim
  (Situation B). This is the one that traps you.

**Situation A — flatten opened the commit buffer (best case).**
The terminal hides itself and the commit message is a real buffer in your Neovim.

- Write the message, then **`:wq`** (or `ZZ`) → the commit completes and the
  terminal reappears.
- To **abort**: `:q!` (an empty/unsaved message cancels the commit).

**Situation B — a nested nvim is running inside the terminal (your screenshot).**
Do **not** press `:q` here — in the outer nvim that closes the toggleterm split
and leaves the commit hanging. Instead, send your keys *into* the inner editor:

1. **Get back into the terminal:** move the cursor to the terminal window and
   press **`i`** (or `a`) to enter terminal mode. Now your keystrokes go to the
   *inner* nvim (which is sitting in normal mode on the commit message).
2. **Finish the commit:** type **`:wq`** then `Enter`. The inner nvim saves
   `COMMIT_EDITMSG` and exits, git makes the commit, and you land back at the
   shell prompt.
3. **To abort instead:** type **`:cq`** (quit with error → git cancels) or `:q!`.

> **Why it traps you:** you pressed `<Esc>`/`jk` (the toggleterm mappings) which
> left terminal mode and put you in the *outer* nvim. From there `:q` acts on the
> outer nvim → it closes the terminal window. The inner nvim only hears you while
> you're in terminal mode (`i`).

**Prevent Situation B — make flatten always catch it.** Nested editors happen
when git launches its own editor without connecting to your running Neovim. Set
your git editor to plain `nvim` so flatten's guest hook intercepts it:

```bash
git config --global core.editor nvim
# and in your shell profile (~/.zshrc):
export EDITOR=nvim
```

**Any other stuck case:** `:qa` quits all nvim windows; at a bare terminal prompt
run `exit`, or `<C-\>` to toggle the terminal away.

> Rule of thumb: in the **outer** nvim, `<Esc>` → `:q`. Inside a **nested** nvim
> (statusline shows `#toggleterm`), `i` first, then `:wq`.

---

## Notes

- Deprecation warnings from pinned plugins are silenced at the top of `init.lua`
  (`vim.deprecate = function() end`). Run `:checkhealth vim.deprecated` any time
  to see what's actually deprecated.
- `neo-tree.lua_disable` and `typescript-tools.lua_disable` are disabled specs —
  rename them back to `.lua` to re-enable.
- `queries/markdown/injections.scm` overrides nvim-treesitter's markdown
  injection query. Its `#set-lang-from-info-string!` directive crashes on
  Neovim 0.12 (the query-match API changed to a list of nodes), so this file
  swaps in the crash-safe, Neovim-native version. Don't delete it unless you
  move nvim-treesitter to its `main` branch.
- Health check for the whole setup: `:checkhealth`.
