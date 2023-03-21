local keymap = vim.keymap
local opts = { noremap = true, silent = true}

--Increment/Decrement
--keymap.set('n', '+', '<C-a>')
--keymap.set('n', '-', '<C-x>')

--Finding file
keymap.set('n', '<leader>f', ':find ')

--Snippets
keymap.set('n', ',htm', ':-1read $HOME/.vi/snippets/.skeleton.htm<CR> 6jvit')
keymap.set('n', ',cpp', ':-1read $HOME/.vi/snippets/.skeleton.cpp<CR> 5jO')

--Delete word backward
--keymap.set('n', 'dw', 'vb"_d')

--Select all
--keymap.set('n', '<C-a>', 'gg<S-v>G', opts)

--Pasting without copying
keymap.set("x", "<leader>p", "\"_dp")

--Do not yank with "x"
keymap.set("n", "x", '"_x')

--Do not yank with "s"
keymap.set("n", "s", '"_s')

keymap.set("n", "J", "mzJ`z")

--Moving highlighted block
keymap.set('v', "J", ":m '>+1<CR>gv=gv")
keymap.set('v', "K", ":m '<-2<CR>gv=gv")

--Buffer
keymap.set('n', '<leader>bk', ':bw<Return>', {silent = true})
--keymap.set("n", "<leader>bp", ":bprevious<Return>",{silent = true} )
--keymap.set("n", "<leader>bi", ":ls<Return>", {silent = true})
--
keymap.set('n', '<leader>vv', ':Ex<Return>', opts)

--Split
keymap.set('n', '<leader>ss', ':split<Return><C-w>w', opts)
keymap.set('n', '<leader>sv', ':vsplit<Return><C-w>w', opts)

--Navigation
keymap.set('n', '<leader>h', '<C-w>h')
keymap.set('n', '<leader>j', '<C-w>j')
keymap.set('n', '<leader>k', '<C-w>k')
keymap.set('n', '<leader>l', '<C-w>l')

keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
