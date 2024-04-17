return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "html",
        "json",
        "proto",
        "sql",
        "svelte",
        "tsx",
        "typescript",
        "yaml"
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
