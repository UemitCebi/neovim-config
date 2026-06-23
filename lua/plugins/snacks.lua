return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      preset = {
        header = [[
       ████ ██████           █████      ██
      ███████████             █████
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "recent_files", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
  },
  keys = {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "LazyGit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Git log" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse" },
  },
}
