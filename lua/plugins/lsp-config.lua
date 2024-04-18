return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- ensure_installed = {"lua_ls", "eslint", "golangci_lint_ls", "gopls", "html", "svelte", "tsserver"},
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.svelte.setup({})
      lspconfig.tailwindcss.setup({})
      lspconfig.html.setup({})
      lspconfig.gopls.setup({})
      lspconfig.eslint.setup({})
      -- lspconfig.golangci_lint_ls.setup({})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Open hover" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
    end,
  },
}
