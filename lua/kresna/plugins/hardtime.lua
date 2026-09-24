return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = "VeryLazy",
  opts = {
    -- "hint" only nudges you toward better motions; it does NOT block keys
    -- (less frustrating than the default "block" while you're learning).
    restriction_mode = "hint",
    disable_mouse = false, -- keep the mouse usable
    -- Re-enable the arrow keys (hardtime disables them by default). We keep the
    -- hints for repeated hjkl/motions, but arrows work normally.
    disabled_keys = {
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<Left>"] = {},
      ["<Right>"] = {},
    },
  },
  -- Toggle it with :Hardtime toggle  (or :Hardtime disable / enable)
}
