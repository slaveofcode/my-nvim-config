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
    -- Open lazygit for the repo of the file in the CURRENT tab/window. In a
    -- monorepo (nested git repos per service) this picks the right repo,
    -- unlike plain :LazyGit which uses Neovim's cwd.
    { "<leader>gg", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit (current tab's repo)" },
    -- Explicit fallbacks:
    { "<leader>gG", "<cmd>LazyGit<CR>", desc = "LazyGit (Neovim cwd / :pwd)" },
    { "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit (current file's repo)" },
  },
}
