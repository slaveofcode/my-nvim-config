return {
  "tris203/precognition.nvim",
  event = "VeryLazy",
  opts = {
    startVisible = true, -- show motion hints from the start (it's a learning aid)
  },
  keys = {
    { "<leader>uh", function() require("precognition").toggle() end, desc = "Toggle motion hints (precognition)" },
  },
}
