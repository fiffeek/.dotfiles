return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {},
      ansiblels = {},
      marksman = {},
      cssls = {},
      html = {},
      yamlls = {
        settings = {
          yaml = {
            customTags = {
              "!reference sequence", -- necessary for gitlab-ci.yaml files
            },
          },
        },
      },
    },
  },
}
