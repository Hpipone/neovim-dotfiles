return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    scroll = {
      animate = {
        duration = { step = 10, total = 250 },
        easing = "linear",
      },

      animate_repeats = {
        duration = { step = 5, total = 50 },
        easing = "quad",
      },
    },
    bigfile = { enabled = false, size = 2 * 1024 * 1024 },
    input = { enabled = true },
    notifier = { enabled = true },
    lazygit = { enabled = true },

    dashboard = {
      enabled = true,
      preset = {
        header = [[
  ██╗  ██╗██████╗ ██╗██████╗  ██████╗ ███╗   ██╗███████╗
  ██║  ██║██╔══██╗██║██╔══██╗██╔═══██╗████╗  ██║██╔════╝
███████║██████╔╝██║██████╔╝██║   ██║██╔██╗ ██║█████╗
██╔══██║██╔═══╝ ██║██╔═══╝ ██║   ██║██║╚██╗██║██╔══╝
  ██║  ██║██║     ██║██║     ╚██████╔╝██║ ╚████║███████╗
  ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚══════╝

        ]],
      },
    },

    explorer = {
      enabled = true,
    },

    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "left" } },
          hidden = true,
          ignored = true,
        },
      },
    },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)
    vim.ui.input = require("snacks.input").input
    vim.ui.select = snacks.picker.select
  end,
  keys = {
    { "<leader>g", "<cmd>lua Snacks.lazygit()<CR>", desc = "Open Lazygit" },
    { "<Tab>", "<cmd>lua Snacks.explorer()<CR>", desc = "Open Explorer" },
    { "<leader>ff", "<cmd>lua Snacks.picker.files()<CR>", desc = "Open file picker" },
    { "<leader>fg", "<cmd>lua Snacks.picker.grep()<CR>", desc = "Open grep picker" },
    { "<leader>fw", "<cmd>lua Snacks.picker.grep_word()<CR>", desc = "Open grep word picker" },
    { "<leader>fh", "<cmd>lua Snacks.picker.help()<CR>", desc = "Open help" },
    { "<leader>fo", "<cmd>lua Snacks.picker.recent()<CR>", desc = "Open recent files" },
    { "<leader>fs", "<cmd>lua Snacks.picker.lsp_symbols()<CR>", desc = "Pick LSP symbols" },
    { "<leader>z", "<cmd>lua Snacks.zen()<CR>", desc = "Toggle Zen mode" },
  },
}
