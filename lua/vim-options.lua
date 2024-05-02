vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
--vim.cmd("set number")
vim.g.mapleader = " "
vim.g.background = "dark"

vim.opt.swapfile = false

vim.wo.number = true

vim.o.updatetime = 250

-- autoformat on save
vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")
