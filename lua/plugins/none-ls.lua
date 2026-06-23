return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    {
      "ThePrimeagen/refactoring.nvim",
      dependencies = { "lewis6991/async.nvim", "nvim-treesitter/nvim-treesitter" },
    },
  },
  config = function()
    require("refactoring").setup()

    local null_ls = require("null-ls")
    local extras = require("none-ls.diagnostics.eslint_d")

    local function cmd_exists(cmd)
      return vim.fn.executable(cmd) == 1
    end

    local function file_exists(params)
      return params.bufname ~= "" and vim.uv.fs_stat(params.bufname) ~= nil
    end

    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.buf,
      null_ls.builtins.code_actions.refactoring,
      extras,
    }

    -- only register diagnostic sources whose CLI tool is actually installed
    if cmd_exists("ec") or cmd_exists("editorconfig-checker") then
      table.insert(sources, null_ls.builtins.diagnostics.editorconfig_checker.with({
        runtime_condition = file_exists,
      }))
    end
    if cmd_exists("markdownlint") then
      table.insert(sources, null_ls.builtins.diagnostics.markdownlint.with({
        runtime_condition = file_exists,
      }))
    end
    if cmd_exists("markuplint") then
      table.insert(sources, null_ls.builtins.diagnostics.markuplint.with({
        runtime_condition = file_exists,
      }))
    end
    if cmd_exists("tidy") then
      table.insert(sources, null_ls.builtins.diagnostics.tidy.with({
        runtime_condition = file_exists,
      }))
    end

    null_ls.setup({
      should_attach = function(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local buftype = vim.bo[bufnr].buftype
        local filetype = vim.bo[bufnr].filetype
        -- skip oil directory buffers, virtual buffers, and non-file buffers
        return buftype == ""
          and filetype ~= "oil"
          and not bufname:match("^oil://")
      end,
      sources = sources,
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
