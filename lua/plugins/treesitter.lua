return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(ev)
        local ok, lang = pcall(vim.treesitter.language.get_lang, ev.match)
        lang = ok and lang or ev.match

        if not vim.tbl_contains(ts.get_installed(), lang) then
          if not vim.tbl_contains(ts.get_available(), lang) then
            return
          end
          ts.install(lang):wait(120000)
        end

        vim.treesitter.start(ev.buf, lang)
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
