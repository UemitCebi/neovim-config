return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
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

    -- Navigate slots with <C-1>–<C-6>
    for i = 1, 6 do
      vim.keymap.set("n", "<C-" .. i .. ">", function()
        harpoon:list():select(i)
      end, { desc = "Harpoon slot " .. i })
    end
  end,
}
