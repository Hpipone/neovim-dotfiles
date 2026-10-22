require("Hpipone.set")
require("Hpipone.keymaps")
-- load plugins if not vscode
if not vim.g.vscode then
  -- bootstrap lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- vim.tbl_flatten is deprecated (removed in Nvim 0.13); shim it so plugins still using it stay quiet and future-proof
  vim.tbl_flatten = function(list)
    return vim.iter(list):flatten():totable()
  end

  require("lazy").setup("plugins", {
    ui = {
      border = "rounded",
    },
  })

  require("config.lsp")

  -- add custom filetypes here
  vim.filetype.add({
    extension = {
      ejs = "html",
    },
  })
end
