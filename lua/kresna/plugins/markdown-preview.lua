return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  -- Build the preview server binary without needing yarn.
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    -- open the preview in the default browser
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_auto_close = 1 -- close the preview tab when leaving the markdown buffer
  end,
  config = function()
    -- toggle the browser preview for the current markdown file
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown preview toggle" })
  end,
}
