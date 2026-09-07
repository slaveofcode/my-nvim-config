return {
  "kylechui/nvim-surround",
  version = "*", -- use the latest stable release
  event = "VeryLazy",
  opts = {},
  -- Default mappings:
  --   ys{motion}{char}  add surround      (e.g. ysiw)  -> wrap word in )
  --   cs{old}{new}      change surround   (e.g. cs"' )  -> "x" becomes 'x'
  --   ds{char}          delete surround   (e.g. ds(  )  -> remove parens
  --   visual mode: select, then S{char}  -> surround the selection
}
