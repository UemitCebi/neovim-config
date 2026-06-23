return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- handled by copilot-cmp
        panel = { enabled = false },      -- handled by copilot-cmp
        filetypes = {
          ["*"] = true,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      -- monkeypatch until https://github.com/zbirenbaum/copilot-cmp/pull/133 is merged
      local source = require("copilot_cmp.source")
      source.is_available = function(self)
        if self.client:is_stopped() or not self.client.name == "copilot" then
          return false
        end
        return next(vim.lsp.get_clients({
          bufnr = vim.api.nvim_get_current_buf(),
          id = self.client.id,
        })) ~= nil
      end
      require("copilot_cmp").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "zbirenbaum/copilot-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "copilot",  group_index = 1 },
          { name = "nvim_lsp", group_index = 1 },
          { name = "luasnip",  group_index = 1 },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
