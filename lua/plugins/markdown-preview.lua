-- return {
--   "iamcco/markdown-preview.nvim",
--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--   ft = { "markdown" },
--   build = function() vim.fn["mkdp#util#install"]() end, 
--   keys = {
--   { "<leader>mp", ":MarkdownPreviewToggle<CR>", desc = "Open Markdown Preview" },
--   },
-- }

return {
  "selimacerbas/markdown-preview.nvim",
  dependencies = { "selimacerbas/live-server.nvim" },
  config = function()
    require("markdown_preview").setup({
      -- all optional; sane defaults shown
      instance_mode = "takeover",  -- "takeover" (one tab) or "multi" (tab per instance)
      port = 0,                    -- 0 = auto (8421 for takeover, OS-assigned for multi)
      open_browser = true,
      default_theme = "light",      -- "dark" or "light"; 
      debounce_ms = 300,
    })
  end,
  keys = {
  { "<leader>mp", ":MarkdownPreview<CR>", desc = "Open Markdown Preview" },
  { "<leader>mS", ":MarkdownPreviewStop<CR>", desc = "Stop Markdown Preview" },
  },
}
