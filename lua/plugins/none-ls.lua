return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
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

    -- eslint (v9+/eslint_d v15) is flat-config only. Only run eslint_d when a
    -- config is actually resolvable, otherwise it prints
    -- "Error: Could not find config file." (non-JSON), which none-ls surfaces as
    -- `failed to decode json: Expected value but found invalid token...`.
    local eslint_configs = {
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
      "eslint.config.ts",
      "eslint.config.mts",
      "eslint.config.cts",
    }
    local function has_eslint_config(params)
      if not file_exists(params) then
        return false
      end
      local found = vim.fs.find(eslint_configs, {
        upward = true,
        path = vim.fs.dirname(params.bufname),
        type = "file",
      })
      return #found > 0
    end

    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.buf,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.code_actions.refactoring,
      extras.with({
        runtime_condition = has_eslint_config,
      }),
    }

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

    null_ls.setup({
      should_attach = function(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local buftype = vim.bo[bufnr].buftype
        local filetype = vim.bo[bufnr].filetype
        return buftype == ""
          and filetype ~= "oil"
          and not bufname:match("^oil://")
      end,
      sources = sources,
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
