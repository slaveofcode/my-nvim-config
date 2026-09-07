return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 900
  end,
  -- which-key v3 API. The old v2 keys (window, key_labels, operators,
  -- triggers_nowait, triggers_blacklist, popup_mappings, ignore_missing,
  -- motions, hidden, triggers="auto") were renamed/removed — see
  -- ":checkhealth which-key". This keeps the same behavior with v3 options.
  opts = {
    delay = 900, -- ms to wait before the popup appears (matches timeoutlen)
    plugins = {
      marks = true, -- show marks on ' and `
      registers = true, -- show registers on " (normal) / <C-r> (insert)
      spelling = {
        enabled = true, -- show suggestions on z=
        suggestions = 20,
      },
      presets = {
        operators = true, -- help for d, y, ...
        motions = true, -- help for motions
        text_objects = true, -- help after an operator
        windows = true, -- <c-w> bindings
        nav = true, -- window navigation
        z = true, -- z-prefixed (folds, spelling)
        g = true, -- g-prefixed
      },
    },
    icons = {
      breadcrumb = "»", -- active key combo in the command line
      separator = "➜", -- between a key and its label
      group = "+", -- prefixed to a group
    },
    show_help = true,
    show_keys = true,
  },
}
