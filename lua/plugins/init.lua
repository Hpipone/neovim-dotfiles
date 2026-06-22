-- if you're looking for the rest of the plugins, they have their own files!
return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      background_colour = "#000000",
      max_width = 60,
      render = "wrapped-compact",
    },
  },
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      'echasnovski/mini.pick',
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
  },
  {
    "norcalli/nvim-colorizer.lua",
    -- enable = true,
    config = function()
      require("colorizer").setup()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },
}
