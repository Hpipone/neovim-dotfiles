return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-j>", ":ToggleTerm direction=float<CR>", desc = "open terminal via ToggleTerm" },
  },
  config = function()
    require("toggleterm").setup({
      size = 20,
      autochdir = true,
      shade_terminals = true,
      persist_mode = true,
    })

    local group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("TermOpen", {
      group = group,
      pattern = "term://*toggleterm#*",
      callback = function()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<C-J>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end,
    })
  end,
}
