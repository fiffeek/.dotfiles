return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "shellcheck",
      "black",
      "isort",
      "bzl",
    },
  },
}