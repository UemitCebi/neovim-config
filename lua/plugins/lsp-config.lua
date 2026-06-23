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
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local diag_float_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }

      -- Attach CursorHold diagnostic float to every LSP buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = args.buf,
            callback = function()
              vim.diagnostic.open_float(nil, diag_float_opts)
            end,
          })
        end,
      })

      -- New nvim 0.11 API: vim.lsp.config + vim.lsp.enable
      local servers = { "lua_ls", "ts_ls", "svelte", "tailwindcss", "html", "gopls" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end
      vim.lsp.enable(servers)

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })

      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next({ float = diag_float_opts })
      end, { desc = "Next diagnostic" })
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev({ float = diag_float_opts })
      end, { desc = "Prev diagnostic" })

      vim.keymap.set("n", "<C-W>d", function()
        vim.diagnostic.open_float(nil, diag_float_opts)
      end, { desc = "Open diagnostics float" })
    end,
  },
}
