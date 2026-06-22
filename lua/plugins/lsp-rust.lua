return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "simrat39/rust-tools.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    
    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    })
  end,
}
