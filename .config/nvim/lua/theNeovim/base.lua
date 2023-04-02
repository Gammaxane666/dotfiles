vim.cmd('autocmd!')

vim.g.mapleader = ' '
vim.g.netrw_banner=0
vim.g.netrw_altv=1
vim.g.netrw_liststyle=0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.o.expandtab = 4
vim.opt.shiftwidth = 4

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vi/undodir"
vim.opt.undofile = true
vim.opt.path:append{'**'}

vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.cursorline = false
vim.opt.updatetime = 50
vim.opt.scrolloff = 8
vim.wo.wrap = false
vim.opt.signcolumn = "yes"

vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank() {timeout=10}')
