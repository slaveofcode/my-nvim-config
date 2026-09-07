return {
  "kdheepak/lazygit.nvim",
  -- lazy-load on the commands and the keymap below
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- for the floating window
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit (open git UI)" },
    { "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit for current file's repo" },
  },
}
