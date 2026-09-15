return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
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
      local python_path = vim.fn.exepath("python3")
      if python_path == "" then
        python_path = vim.fn.exepath("python")
      end

      local ok_registry, registry = pcall(require, "mason-registry")
      if ok_registry then
        local ok_pkg, pkg = pcall(registry.get_package, "debugpy")
        if ok_pkg and pkg:is_installed() then
          local install_path = pkg:get_install_path()
          local candidate = install_path .. "/venv/bin/python"
          if vim.fn.executable(candidate) == 1 then
            python_path = candidate
          end
        end
      end

      require("dap-python").setup(python_path)
      local ok_dap, dap = pcall(require, "dap")
      if ok_dap then
        dap.defaults.python.justMyCode = false
      end
    end,
  },
}
