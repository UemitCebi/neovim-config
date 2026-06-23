return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>h",  desc = "Toggle Harpoon list" },
    { "<leader>ha", desc = "Add current buffer to harpoon" },
    { "<leader>hc", desc = "Clear Harpoon list" },
    { "<C-1>",      desc = "Harpoon slot 1" },
    { "<C-2>",      desc = "Harpoon slot 2" },
    { "<C-3>",      desc = "Harpoon slot 3" },
    { "<C-4>",      desc = "Harpoon slot 4" },
    { "<C-5>",      desc = "Harpoon slot 5" },
    { "<C-6>",      desc = "Harpoon slot 6" },
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle Harpoon list" })
    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Add current buffer to harpoon" })
    vim.keymap.set("n", "<leader>hc", function()
      harpoon:list():clear()
    end, { desc = "Clear Harpoon list" })

    for i = 1, 6 do
      vim.keymap.set("n", "<C-" .. i .. ">", function()
        harpoon:list():select(i)
      end, { desc = "Harpoon slot " .. i })
    end
  end,
}
