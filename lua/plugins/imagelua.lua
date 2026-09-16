return {

  "3rd/image.nvim",
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    processor = "magick_cli",
    backend = "sixel",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        only_render_image_at_cursor = true, -- penting untuk performa sixel
        only_render_image_at_cursor_mode = "popup",
      },
    },
  },
}
