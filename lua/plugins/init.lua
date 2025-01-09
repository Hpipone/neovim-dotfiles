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
      -- You can choose one of the following pickers
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      'echasnovski/mini.pick',
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  --autopair and autotag for web dev
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
    enable = true,
    config = function()
      require("colorizer").setup()
    end
  },
  -- Auto format tools
  {
    "sbdchd/neoformat",
    cmd = { "Neoformat" }
  },
  -- Git command inside vim
  -- Better git log display
  {
    "rbong/vim-flog",
    cmd = { "Flog" }
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "ruifm/gitlinker.nvim",
    event = "User InGitRepo",
    config = function()
    end,
  },
  -- Show git change (change, delete, add) signs in vim sign column
  {
    "sindrets/diffview.nvim",
  },
  {
    "declancm/cinnamon.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        basic = true,
        extra = true,
      },
      options = {
        delay = 1,
        step_size = {
          -- Number of cursor/window lines moved per step
          vertical = 3,
          -- Number of cursor/window columns moved per step
          horizontal = 2,
        },
      },
    },
  },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },
}
