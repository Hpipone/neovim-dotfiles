return {
  "nvim-tree/nvim-tree.lua", -- file explorer
  keys = {
  },
  cmd = "NvimTreeToggle",
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_netrw = true,
  hijack_cursor = false,
  hijack_unnamed_buffer_when_opening = false,
  sort_by = "name",
  update_cwd = false,
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  opts = {
    view = {
      side = "left",
      width = 36,
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
  },
}
