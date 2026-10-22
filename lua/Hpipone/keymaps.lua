local keymap = vim.keymap

-- stolen from thePrimeAgen
-- keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "x", '"_x')

--[[ keymap.set("n", "<C-w>", "<C-ww>") ]]
--keymap.set("n", "<TAB>", ":NvimTreeToggle<CR>", { silent = true, desc = "tab nvim tree sitter" })
keymap.set("n", "<leader>p", ":LivePreview start<CR>", { silent = true, desc = "livepreview startto" })

-- keymap.set("n", "+", "<C-a>")
-- keymap.set("n", "_", "<C-x>")
keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "menghilangkan hightlight search" })

-- split windows
keymap.set("n", "ss", ":split<CR><C-w>w", { silent = true, desc = "mindahin nvim ke sebelah atas ato bawah" })
keymap.set("n", "sv", ":vsplit<CR><C-w>w", { silent = true, desc = "mindahin nvim ke sebelah kanan ato kiri" })

-- switch windows
keymap.set("n", "<C-l>", "<C-w>w")

-- Resize window
keymap.set("n", "<S-k>", ":vertical resize -4<CR>")
keymap.set("n", "<S-l>", ":vertical resize +4<CR>")
keymap.set("n", "<S-h>", ":resize +4<CR>")
keymap.set("n", "<S-j>", ":resize -4<CR>")

-- tabs
local tabopts = { silent = true }
keymap.set("n", "<C-t>", ":tabedit<CR>", tabopts)
-- keymap.set("n", "<C-o>", ":tabclose<CR>", tabopts)
keymap.set("n", "<s-r>", ":tabprev<Return>", tabopts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file
keymap.set("n", "<C-s>", ":w<CR>")

-- Keluar file & Quit all opened buffers
keymap.set("n", "q", ":q<CR>")
keymap.set("n", "<leader>q", ":qa!<cr>", { silent = true, desc = "force quit nvim" })

-- Alert wrong keymap
keymap.set("n", "<C-z>", ":lua require('notify')('Bruh did you mean to press u?', 'info')<CR>", { silent = true })
keymap.set("n", "<C-c>", ":lua require('notify')('Bruh did you mean to press y?', 'info')<CR>", { silent = true })
keymap.set("n", "<C-v>", ":lua require('notify')('Bruh did you mean to press p?', 'info')<CR>", { silent = true })

-- Code folding
keymap.set("n", "<leader>mf", "zf}", {desc = "[Normal] buat code folding sampe spasi"})
keymap.set("v", "<leader>mf", "zf}", {desc = "[visual] buat code folding sampe spasi"})
keymap.set("n", "<leader>ms", ":mkview<cr>", {desc = "save code folding"})
keymap.set("n", "<leader>ml", ":loadview<cr>", {desc = "load code folding yang udh disave"})
keymap.set("n", "<leader>mg", "zfg", {desc = "buat code folding ampe paling bawah"})
keymap.set("n", "<leader>mo", "zO", {desc = "buka semua code folding"})
keymap.set("n", "<leader>mm", "zM", {desc = "tutup semua code folding"})


