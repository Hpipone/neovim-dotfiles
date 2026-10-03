local servers = {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
  },
  vtsls = {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  },
  html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_markers = { "package.json", ".git" },
  },
  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
  },
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { "package.json", ".git" },
  },
  marksman = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    root_markers = { ".git" },
  },
  emmet_ls = {
    cmd = { "emmet-ls", "--stdio" },
    filetypes = {
      "html",
      "css",
      "sass",
      "scss",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "astro",
      "blade",
      "php",
    },
    root_markers = { ".git" },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, "blink.cmp")
if ok then
  capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
end

vim.lsp.config("*", { capabilities = capabilities })

local enabled = {}
for name, cfg in pairs(servers) do
  vim.lsp.config(name, cfg)
  if vim.fn.executable(cfg.cmd[1]) == 1 then
    table.insert(enabled, name)
  end
end

if #enabled > 0 then
  vim.lsp.enable(enabled)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
  callback = function(ev)
    local function map(lhs, rhs, desc, opts)
      vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", { buffer = ev.buf, desc = "LSP: " .. desc }, opts or {}))
    end

    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("gr", vim.lsp.buf.references, "References")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    map("<space>D", vim.lsp.buf.type_definition, "Goto Type Definition")

    local saga = { silent = true }
    map("[d", ":Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic", saga)
    map("]d", ":Lspsaga diagnostic_jump_prev<CR>", "Prev Diagnostic", saga)
    map("<F2>", ":Lspsaga rename<CR>", "Rename", saga)
    map("<leader>ca", ":Lspsaga code_action<CR>", "Code Action", saga)
    map("<leader>o", ":Lspsaga outline<CR>", "Outline", saga)
  end,
})
