return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.buf,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.buitlins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.markuplint,
        null_ls.builtins.diagnostics.protolint,
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.tidy,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
    -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.diagnose, {})
  end,
}
