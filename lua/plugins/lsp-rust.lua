return {
  vim.lsp.config("rust_analyzer", {
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
  }),
vim.lsp.enable("rust_analyzer")
}
