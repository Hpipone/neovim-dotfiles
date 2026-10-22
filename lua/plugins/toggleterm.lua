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

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-J>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
  end,
}
