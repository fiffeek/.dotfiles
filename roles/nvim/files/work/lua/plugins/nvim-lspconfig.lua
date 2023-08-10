return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {},
      marksman = {},
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
