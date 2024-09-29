return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local conditional = function(builtin)
      local utils = require("null-ls.utils").make_conditional_utils()
      if utils.root_has_file("Gemfile") then
        return builtin.with({
          command = "bundle",
          args = vim.list_extend({ "exec", "rubocop" }, builtin._opts.args),
        })
      else
        return builtin
      end
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        conditional(null_ls.builtins.diagnostics.rubocop),
        conditional(null_ls.builtins.formatting.rubocop),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
