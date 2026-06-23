return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local wk = require("which-key")
    wk.add({
      { "<leader>g", group = "goto / git / format" },
      { "<leader>h", group = "harpoon" },
      { "<leader>d", group = "debug" },
      { "<leader>z", group = "folds" },
      { "<leader>c", group = "code" },
      { "<leader>r", group = "refactor" },
      { "<leader>f", group = "find" },
    })
  end,
  opts = {},
}
