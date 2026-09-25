return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local nvimtree = require("nvim-tree")
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- Keep nvim-tree's default keys, then add our own:
    --   t   open a floating terminal in the folder under the cursor
    --   gl  open lazygit for the git repo that folder belongs to
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr) -- apply all default mappings

      -- directory of the node under the cursor (a folder itself, or a file's parent)
      local function node_dir()
        local node = api.tree.get_node_under_cursor()
        if node and node.absolute_path then
          return node.type == "directory" and node.absolute_path
            or vim.fn.fnamemodify(node.absolute_path, ":h")
        end
        return vim.fn.getcwd()
      end

      -- t -> floating terminal in this folder
      vim.keymap.set("n", "t", function()
        require("toggleterm.terminal").Terminal
          :new({ dir = node_dir(), direction = "float", close_on_exit = true })
          :toggle()
      end, {
        desc = "nvim-tree: open terminal in this folder",
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true, -- fire immediately, don't wait out timeoutlen for a `t` motion
      })

      -- gl -> lazygit for this folder's git repo
      vim.keymap.set("n", "gl", function()
        local dir = node_dir()
        local root = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]
        if vim.v.shell_error ~= 0 or not root or root == "" then
          vim.notify("lazygit: not inside a git repo: " .. dir, vim.log.levels.WARN)
          return
        end
        require("lazygit").lazygit(root)
      end, {
        desc = "nvim-tree: open lazygit for this folder's repo",
        buffer = bufnr,
        noremap = true,
        silent = true,
      })

      -- <leader>cd -> make the folder under the cursor the tree root ("cd into").
      -- Same as the default <C-]>; `-` (default) goes back up a level.
      vim.keymap.set("n", "<leader>cd", api.tree.change_root_to_node, {
        desc = "nvim-tree: set this folder as root",
        buffer = bufnr,
        noremap = true,
        silent = true,
      })
    end

    nvimtree.setup({
      on_attach = on_attach,
      sort_by = "case_sensitive",
      view = {
        width = 35,
        relativenumber = true,
      },
      filters = {
        dotfiles = false,
      },
       -- change folder arrow icons
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      git = {
        ignore = false,
      },
      -- Share the tree across tabs: if it's open, it appears in every tab you
      -- switch to; closing it in one tab closes it everywhere.
      tab = {
        sync = {
          open = true,
          close = true,
        },
      },

    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus on file explorer" }) -- focus file explorer
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

    -- autocmd BufEnter * if bufname('#') =~ 'NvimTree' && bufname('%') !~ 'NvimTree' && winnr('$') > 1 | execute "normal \<C-^>" | endif
    -- keymaps default 
    -- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
  end
}
