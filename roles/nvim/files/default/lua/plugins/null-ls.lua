return {
  "nvimtools/none-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,
        nls.builtins.code_actions.shellcheck,
        nls.builtins.diagnostics.terraform_validate,
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.terraform_fmt,
        nls.builtins.formatting.clang_format,
      },
    }
  end,
}
