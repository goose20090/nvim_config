return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local conditional = function(fn)
      local utils = require("null-ls.utils").make_conditional_utils()
      return fn(utils)
    end
   null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        conditional(function(utils)
          return utils.root_has_file("Gemfile")
                  and null_ls.builtins.diagnostics.rubocop.with({
                      command = "bundle",
                      args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
                  })
              or null_ls.builtins.diagnostics.rubocop
        end),
        conditional(function(utils)
          return utils.root_has_file("Gemfile")
                  and null_ls.builtins.formatting.rubocop.with({
                      command = "bundle",
                      args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
                  })
              or null_ls.builtins.formatting.rubocop
        end),
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
