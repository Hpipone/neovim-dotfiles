#!/usr/bin/env bash
# Uji shim directive treesitter di lua/plugins/treesitter.lua.
#
# Bug yang dicegah: Neovim 0.12 mengoperasikan match sebagai
# table<integer, TSNode[]>, sedangkan branch master nvim-treesitter masih
# mengharapkan satu TSNode sehingga save markdown melempar
# "attempt to call method 'range' (a nil value)".
#
# Pakai: bash tests/treesitter_shim.sh
set -u

DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT

PROBE_OUT="$DIR/probe.out"
PROBE_ERR="$DIR/probe.err"

printf '# Hi\n\n```lua\nlocal a = 1\n```\n' > "$DIR/test.md"

cat > "$DIR/probe.lua" <<'LUA'
local q = require("vim.treesitter.query")
local registered = {}
for _, name in ipairs(q.list_directives()) do
  registered[name] = true
end

local src = "# Hi\n\n```lua\nlocal a = 1\n```\n"
local parser = vim.treesitter.get_string_parser(src, "markdown")
local tree = parser:parse()[1]
local injections = vim.treesitter.query.get("markdown", "injections")

local lang
local iter_ok, iter_err = pcall(function()
  for _, _, metadata in injections:iter_matches(tree:root(), src, 0, -1) do
    if metadata and metadata["injection.language"] then
      lang = metadata["injection.language"]
    end
  end
end)

local parse_ok, parse_err = pcall(function()
  local p = vim.treesitter.get_string_parser(src, "markdown")
  p:parse(true)
end)

vim.fn.writefile({
  "registered=" .. tostring(
    registered["set-lang-from-info-string!"]
      and registered["set-lang-from-mimetype!"]
      and registered["downcase!"]
  ),
  "language=" .. tostring(lang),
  "iter_ok=" .. tostring(iter_ok) .. " " .. tostring(iter_err),
  "parse_ok=" .. tostring(parse_ok) .. " " .. tostring(parse_err),
}, vim.env.PROBE_OUT)
LUA

fail=0

save_err=$(timeout 60 nvim --headless -n -i NONE \
  -c "edit $DIR/test.md" \
  -c "sleep 2000m" \
  -c "call setline(1, getline(1) . ' edited')" \
  -c "write" \
  -c "sleep 2000m" \
  -c "qa!" 2>&1 >/dev/null | grep -v '^\[nvim-treesitter\]')

if printf '%s' "$save_err" | grep -qE "attempt to call method 'range'|languagetree\.lua"; then
  echo "FAIL: error treesitter saat save"
  printf '%s\n' "$save_err"
  fail=1
fi

if ! PROBE_OUT="$PROBE_OUT" timeout 60 nvim --headless -n -i NONE \
  -c "luafile $DIR/probe.lua" -c "qa!" >/dev/null 2>"$PROBE_ERR"; then
  echo "FAIL: probe gagal dijalankan"
  cat "$PROBE_ERR"
  fail=1
elif [ ! -f "$PROBE_OUT" ]; then
  echo "FAIL: probe tidak menghasilkan output"
  fail=1
else
  registered=$(grep '^registered=' "$PROBE_OUT" | cut -d= -f2-)
  language=$(grep '^language=' "$PROBE_OUT" | cut -d= -f2-)
  iter_ok=$(grep '^iter_ok=' "$PROBE_OUT" | cut -d= -f2- | cut -d' ' -f1)
  parse_ok=$(grep '^parse_ok=' "$PROBE_OUT" | cut -d= -f2- | cut -d' ' -f1)

  [ "$registered" = "true" ] || { echo "FAIL: shim tidak terdaftar (registered=$registered)"; fail=1; }
  [ "$language" = "lua" ] || { echo "FAIL: injection.language=$language, diharapkan lua"; fail=1; }
  [ "$iter_ok" = "true" ] || { echo "FAIL: iter_matches error"; grep '^iter_ok=' "$PROBE_OUT"; fail=1; }
  [ "$parse_ok" = "true" ] || { echo "FAIL: parse error"; grep '^parse_ok=' "$PROBE_OUT"; fail=1; }
fi

if [ "$fail" -eq 0 ]; then
  echo "PASS: shim directive treesitter sehat"
fi
exit "$fail"
