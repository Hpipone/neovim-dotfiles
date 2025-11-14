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
    bigfile = { enabled = true, size = 2 * 1024 * 1024 },
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
      headers = { "%s", align = "center" },
    },

    explorer = { enabled = true },

    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "left" } },
        },
        source = "files",
      },
    },
  },
  keys = {
    { "<leader>g",  "<cmd>lua Snacks.lazygit()<CR>",            desc = "Open Lazygit" },
    { "<Tab>",  "<cmd>lua Snacks.explorer()<CR>",           desc = "Open Explorer" },
    { "<leader>ff", "<cmd>lua Snacks.picker.files()<CR>",       desc = "Open file picker" },
    { "<leader>fg", "<cmd>lua Snacks.picker.grep()<CR>",        desc = "Open grep picker" },
    { "<leader>fw", "<cmd>lua Snacks.picker.grep_word()<CR>",   desc = "Open grep word picker" },
    { "<leader>fh", "<cmd>lua Snacks.picker.help()<CR>",        desc = "Open help" },
    { "<leader>fo", "<cmd>lua Snacks.picker.recent()<CR>",      desc = "Open recent files" },
    { "<leader>fs", "<cmd>lua Snacks.picker.lsp_symbols()<CR>", desc = "Pick LSP symbols" },
    { "<leader>z",  "<cmd>lua Snacks.zen()<CR>",                desc = "Toggle Zen mode" },
  },
}

--[[         local verses = {
          "Aku mengucap syukur kepada Allahku setiap kali aku mengingat kamu.\n" .. "Filipi 1:3",

          "Apa pun juga yang kamu perbuat, perbuatlah dengan segenap hatimu\n"
            .. "seperti untuk Tuhan dan bukan untuk manusia.\n"
            .. "Kolose 3:23",

          "Sebab Aku ini mengetahui rancangan-rancangan apa yang ada pada-Ku\n"
            .. "mengenai kamu demikianlah firman Tuhan, yaitu rancangan damai\n"
            .. "sejahtera dan bukan rancangan kecelakaan,\n"
            .. "untuk memberikan kepadamu hari depan yang penuh harapan.\n"
            .. "Yeremia 29:11",

          "Sebab kami tidak memperhatikan yang kelihatan, melainkan yang tak\n"
            .. "kelihatan arena yang kelihatan adalah sementara, sedangkan\n"
            .. "yang tak kelihatan adalah kekal.\n"
            .. "2 Korintus 4:18",

          "Janganlah hatimu iri kepada orang-orang yang berdosa,\n"
            .. "tetapi takutlah akan Tuhan senantiasa. Karena\n"
            .. "masa depan sungguh ada, dan harapanmu tidak akan hilang.\n"
            .. "mazmur 3:17-18",

          "Bersukacitalah dalam pengharapan, sabarlah dalam kesesakan,\n"
            .. "dan bertekunlah dalam doa!\n"
            .. "Bantulah dalam kekurangan orang-orang kudus dan usahakanlah\n"
            .. "dirimu untuk selalu memberikan tumpangan!\n"
            .. "Roma 12:12-13",
        }
 ]]
