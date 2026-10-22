-- if you're looking for the rest of the plugins, they have their own files!
return {
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
    },
    config = function()
      vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload", "BufWipeout" }, {
        callback = function(args)
          if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].filetype ~= "markdown" then
            return
          end
          vim.schedule(function()
            if not require("livepreview").is_running() then
              return
            end
            local has_md = vim.iter(vim.api.nvim_list_bufs()):any(function(buf)
              return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == "markdown"
            end)
            if not has_md then
              require("livepreview").close()
            end
          end)
        end,
      })
    end,
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
    end,
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
