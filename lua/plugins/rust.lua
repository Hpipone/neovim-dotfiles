return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            check = {
              command = "clippy",
            },
            diagnostics = {
              enable = true,
            },
            procMacro = {
              enable = true,
            },
            files = {
              exclude = {
                ".direnv",
                ".git",
                ".jj",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
              -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
              watcher = "client",
            },
          },
        },
      },
    },
    config = function(_, opts)
      local ok_registry, registry = pcall(require, "mason-registry")
      if ok_registry then
        local ok_pkg, codelldb_pkg = pcall(registry.get_package, "codelldb")
        if ok_pkg and codelldb_pkg:is_installed() then
          local codelldb = vim.fn.exepath("codelldb")
          if codelldb ~= "" then
            local uname = vim.uv.os_uname().sysname
            local codelldb_lib_ext = uname == "Linux" and ".so" or ".dylib"
            local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)
            opts.dap = {
              adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
            }
          end
        end
      end
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        vim.notify(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          vim.log.levels.WARN,
          { title = "rustaceanvim" }
        )
      end
    end,
  },
}
