#!/usr/bin/env bash
set -u

DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT

cd "$(dirname "$0")/.." || exit 1

fail=0
out="$DIR/out"

if [ ! -f lua/notify.lua ]; then
  echo "FAIL: shim notify tidak ada"
  fail=1
fi

if grep -q '"nvim-notify"' lazy-lock.json; then
  echo "FAIL: nvim-notify masih ada di lazy-lock.json"
  fail=1
fi

startup_err=$(timeout 60 nvim --headless -n -i NONE -u init.lua -c "qa!" 2>&1)
if [ -n "$startup_err" ]; then
  echo "FAIL: error saat startup"
  printf '%s\n' "$startup_err"
  fail=1
fi

mkdir -p "$DIR/py" "$DIR/js" "$DIR/bin"
git -C "$DIR" init -q
printf 'print("hi")\n' > "$DIR/py/a.py"
printf 'const x = 1;\n' > "$DIR/js/a.js"
printf 'export default [];\n' > "$DIR/js/eslint.config.mjs"

cat > "$DIR/bin/eslint" <<'SH'
#!/bin/sh
cat >/dev/null
printf '[{"messages":[{"line":1,"column":1,"message":"fake eslint","severity":2}]}]\n'
SH
chmod +x "$DIR/bin/eslint"

OUT="$out" PATH="$DIR/bin:$PATH" timeout 60 nvim --headless -n -i NONE -u init.lua \
  -c "Lazy! load nvim-lint" \
  -c "edit $DIR/js/a.js" \
  -c "sleep 2" \
  -c 'lua vim.fn.writefile({ "diagnostics=" .. tostring(#vim.diagnostic.get(0)) }, vim.env.OUT)' \
  -c "qa!" >/dev/null 2>"$DIR/lint.err"

if [ ! -f "$out" ]; then
  echo "FAIL: lint probe tidak menghasilkan output"
  cat "$DIR/lint.err"
  fail=1
else
  diagnostics=$(cut -d= -f2- "$out")
  [ "$diagnostics" -gt 0 ] || { echo "FAIL: eslint.config.mjs tidak terdeteksi (diagnostics=$diagnostics)"; fail=1; }
fi

rm -f "$out"

OUT="$out" timeout 60 nvim --headless -n -i NONE -u init.lua \
  -c "edit $DIR/py/a.py" \
  -c "sleep 2" \
  -c 'lua vim.fn.writefile({
    "dap=" .. tostring(package.loaded["dap-python"] ~= nil),
    "snacks_notify=" .. tostring(package.loaded["notify"] == nil and debug.getinfo(vim.notify).source:match("snacks") ~= nil),
    "comment_fg=" .. tostring(vim.api.nvim_get_hl(0, { name = "Comment" }).fg ~= nil),
    "nvim_notify_removed=" .. tostring(require("lazy.core.config").plugins["nvim-notify"] == nil),
    "notify_shim=" .. tostring(pcall(require("notify"), "smoke", vim.log.levels.INFO)),
  }, vim.env.OUT)' \
  -c "qa!" >/dev/null 2>"$DIR/python.err"

if [ ! -f "$out" ]; then
  echo "FAIL: python probe tidak menghasilkan output"
  cat "$DIR/python.err"
  fail=1
else
  [ "$(grep '^dap=' "$out" | cut -d= -f2-)" = "true" ] || { echo "FAIL: nvim-dap-python tidak termuat"; cat "$DIR/python.err"; fail=1; }
  [ "$(grep '^snacks_notify=' "$out" | cut -d= -f2-)" = "true" ] || { echo "FAIL: vim.notify bukan Snacks"; fail=1; }
  [ "$(grep '^comment_fg=' "$out" | cut -d= -f2-)" = "true" ] || { echo "FAIL: highlight Comment tidak punya fg"; fail=1; }
  [ "$(grep '^nvim_notify_removed=' "$out" | cut -d= -f2-)" = "true" ] || { echo "FAIL: nvim-notify masih terdaftar"; fail=1; }
  [ "$(grep '^notify_shim=' "$out" | cut -d= -f2-)" = "true" ] || { echo "FAIL: shim notify gagal"; fail=1; }
fi

for spec in "rs:fn main(){let x=1;}" "go:package main
func main(){x:=1;_=x}"; do
  ext=${spec%%:*}
  text=${spec#*:}
  file="$DIR/format.$ext"
  printf '%s\n' "$text" > "$file"
  timeout 30 nvim --headless -n -i NONE -u init.lua \
    -c "edit $file" -c "write" -c "sleep 1" -c "qa!" >/dev/null 2>&1
  if [ "$ext" = "rs" ] && ! grep -q "^fn main() {" "$file"; then
    echo "FAIL: rustfmt tidak jalan"
    fail=1
  fi
  if [ "$ext" = "go" ] && ! grep -q "func main() {" "$file"; then
    echo "FAIL: gofmt tidak jalan"
    fail=1
  fi
done

if [ "$fail" -eq 0 ]; then
  echo "PASS: config smoke test sehat"
fi

exit "$fail"
