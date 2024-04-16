return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        -- theme = 'nightfly'
        theme = 'ayu_mirage'
      }
    })
  end
}
