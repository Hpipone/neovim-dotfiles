return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      styles = {
        conditionals = { "altfont" },
      },
      integrations = {
        lsp_saga = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
