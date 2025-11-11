return {
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
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_, _)
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
      require("dap").defaults.python.justMyCode = false
    end,
  }
}
