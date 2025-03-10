vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
--vim.cmd("set number")
vim.g.mapleader = " "
vim.g.background = "dark"

vim.opt.swapfile = false

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.wo.number = true

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4

local function close_all_folds()
  vim.api.nvim_exec2("%foldc!", { output = false })
end
local function open_all_folds()
  vim.api.nvim_exec2("%foldo!", { output = false })
end

vim.keymap.set("n", "<leader>zs", close_all_folds, { desc = "[s]hut all folds" })
vim.keymap.set("n", "<leader>zo", open_all_folds, { desc = "[o]pen all folds" })

vim.o.updatetime = 250

-- autoformat on save
vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.format()")

vim.filetype.add({
  extension = {
    postcss = "css",
    pcss = "css",
  },
})
