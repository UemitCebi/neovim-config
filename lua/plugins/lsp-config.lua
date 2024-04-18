return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    }
    --[[
    config = function()
      require("mason-lspconfig").setup({
        -- ensure_installed = {"lua_ls", "eslint", "golangci_lint_ls", "gopls", "html", "svelte", "tsserver"},
        automatic_installation = true,
      })
    end,
    ]]
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({capabilities = capabilities})
      lspconfig.tsserver.setup({capabilities = capabilities})
      lspconfig.svelte.setup({capabilities = capabilities})
      lspconfig.tailwindcss.setup({capabilities = capabilities})
      lspconfig.html.setup({capabilities = capabilities})
      lspconfig.gopls.setup({capabilities = capabilities})
      lspconfig.eslint.setup({capabilities = capabilities})

      -- lspconfig.golangci_lint_ls.setup({})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Open hover" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
    end,
  },
}
