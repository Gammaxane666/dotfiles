local opts = { silent = true }

--Increment/Decrement
--keymap.set('n', '+', '<C-a>')
--keymap.set('n', '-', '<C-x>')

--Finding file
vim.keymap.set('n', '<leader>f', ':find ')

--Snippets
vim.keymap.set('n', '<leader>htm', ':-1read $HOME/.vi/snippets/.skeleton.htm<CR> 6jvit')
vim.keymap.set('n', '<leader>cpp', ':-1read $HOME/.vi/snippets/.skeleton.cpp<CR> 4jO')

--Delete word backward
--keymap.set('n', 'dw', 'vb"_d')

--Select all
--keymap.set('n', '<C-a>', 'gg<S-v>G', opts)

--Pasting without copying
vim.keymap.set("x", "<leader>p", [["_dP]])

--Do not yank with "x"
vim.keymap.set("n", "x", '"_x')

--Do not yank with "s"
vim.keymap.set("n", "s", '"_s')

vim.keymap.set("n", "J", "mzJ`z")

--Moving highlighted block
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

--Buffer
vim.keymap.set('n', '<leader>bk', ':bw<Return>', opts)
--keymap.set("n", "<leader>bp", ":bprevious<Return>",{silent = true} )
--keymap.set("n", "<leader>bi", ":ls<Return>", {silent = true})
--
vim.keymap.set('n', '<leader>vv', ':Ex<Return>', opts)

--Split
vim.keymap.set('n', '<leader>ss', ':split<Return><C-w>w', opts)
vim.keymap.set('n', '<leader>sv', ':vsplit<Return><C-w>w', opts)

--Navigation
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
