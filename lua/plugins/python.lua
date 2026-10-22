return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justMyCode = false },
          args = { "--capture=no" },
          pytest_discover_instances = true,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local python = vim.fn.exepath("python3") or "python3"

      local registry_ok, registry = pcall(require, "mason-registry")
      if registry_ok then
        local debugpy_ok, debugpy = pcall(function()
          return registry.get_package("debugpy")
        end)
        if debugpy_ok and debugpy then
          python = debugpy:get_install_path() .. "/venv/bin/python"
        end
      end

      require("dap-python").setup(python)
      require("dap").defaults.python.justMyCode = false
    end,
  },
}
