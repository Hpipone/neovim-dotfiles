local html_script_type_languages = {
  ["importmap"] = "json",
  ["module"] = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}

local injection_language_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  uxn = "uxntal",
  ts = "typescript",
}

local function first_node(match, capture_id)
  local nodes = match[capture_id]
  if type(nodes) == "table" then
    return nodes[1]
  end
  return nodes
end

local function language_from_info_string(alias)
  local ft = vim.filetype.match({ filename = "a." .. alias })
  return ft or injection_language_aliases[alias] or alias
end

-- Neovim 0.12 mengoperasikan match sebagai table<integer, TSNode[]>, sedangkan
-- branch master nvim-treesitter masih mengharapkan satu TSNode. Tiga directive
-- di bawah adalah satu-satunya yang dipakai query bawaan, jadi cukup didaftarkan
-- ulang di sini daripada mempatch seluruh modul query_predicates.
local function patch_injection_directives()
  require("nvim-treesitter.query_predicates")

  local query = require("vim.treesitter.query")
  local opts = { force = true }

  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match, pred[2])
    if not node then
      return
    end
    local alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = language_from_info_string(alias)
  end, opts)

  query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match, pred[2])
    if not node then
      return
    end
    local value = vim.treesitter.get_node_text(node, bufnr)
    local configured = html_script_type_languages[value]
    if configured then
      metadata["injection.language"] = configured
    else
      local parts = vim.split(value, "/", {})
      metadata["injection.language"] = parts[#parts]
    end
  end, opts)

  query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = first_node(match, id)
    if not node then
      return
    end
    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then
      metadata[id] = {}
    end
    metadata[id].text = string.lower(text)
  end, opts)
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = {
        "python",
        "astro",
        "c",
        "markdown",
        "markdown_inline",
        "cpp",
        "lua",
        "html",
        "go",
        "javascript",
        "css",
        "java",
        "json",
        "rust",
        "ron",
        "arduino",
        "php",
        "dart",
        "htmldjango",
        "dockerfile",
        "bash",
        "typescript",
      },
      auto_install = true,
    })

    patch_injection_directives()
  end,
}
