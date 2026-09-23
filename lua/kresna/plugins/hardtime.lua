return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = "VeryLazy",
  opts = {
    -- "hint" only nudges you toward better motions; it does NOT block keys
    -- (less frustrating than the default "block" while you're learning).
    restriction_mode = "hint",
    disable_mouse = false, -- keep the mouse usable
  },
  -- Toggle it with :Hardtime toggle  (or :Hardtime disable / enable)
}
