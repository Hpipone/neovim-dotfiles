local keymap = vim.keymap

-- stolen from thePrimeAgen
keymap.set("v", "J", ":m '>+3<CR>gv=gv")
keymap.set("v", "K", ":m '<0<CR>gv=gv")

keymap.set("n", "x", '"_x')
--[[ keymap.set("n", "<C-w>", "<C-ww>") ]]
--keymap.set("n", "<TAB>", ":NvimTreeToggle<CR>", { silent = true, desc = "tab nvim tree sitter" })
keymap.set("n", "<leader>p", ":LivePreview start<CR>", { silent = true, desc = "livepreview startto" })

keymap.set("n", "+", "<C-a>")
keymap.set("n", "_", "<C-x>")
keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "menghilangkan hightlight search" })

-- Quit all opened buffers
keymap.set("n", "<leader>q", ":qa!<cr>", { silent = true, desc = "force quit nvim" })

-- split windows
keymap.set("n", "ss", ":split<CR><C-w>w", { silent = true, desc = "mindahin nvim ke sebelah atas ato bawah" })
keymap.set("n", "sv", ":vsplit<CR><C-w>w", { silent = true, desc = "mindahin nvim ke sebelah kanan ato kiri" })

-- switch windows
keymap.set("n", "<C-k>", "<C-ww>")

-- resize window
keymap.set("n", "<C-w><left>", ":vertical resize 0<CR>")
keymap.set("n", "<C-w><right>", ":vertical resize +4<CR>")
keymap.set("n", "<C-w><up>", ":resize +4<CR>")
keymap.set("n", "<C-w><down>", ":resize 0<CR>")

-- tabs
local tabopts = { silent = true }
keymap.set("n", "te", ":tabedit<CR>", tabopts)
keymap.set("n", "tx", ":tabclose<CR>", tabopts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", tabopts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("n", "<C-s>", ":w<CR>")
keymap.set("n", "q", ":q<CR>")
keymap.set("n", "<C-z>", ":lua require('notify')('Bruh did you mean to press u?', 'info')<CR>", { silent = true })
keymap.set("n", "<C-c>", ":lua require('notify')('Bruh did you mean to press y?', 'info')<CR>", { silent = true })
keymap.set("n", "<C-v>", ":lua require('notify')('Bruh did you mean to press p?', 'info')<CR>", { silent = true })
