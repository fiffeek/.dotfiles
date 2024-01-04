return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      },
      ruff_lsp = {
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {"--line-length=120"},
          },
        },
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
        },
      },
      pylsp = {
        settings = {
          pylsp = {
            builtin = {
              installExtraArgs = {'flake8', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylint', 'yapf'},
            },
            plugins = {
              jedi_completion = { enabled = false },
              rope_completion = { enabled = false },
              flake8 = { enabled = false },
              pyflakes = { enabled = false },
              pycodestyle = {
                ignore = {'E226', 'E266', 'E302', 'E303', 'E304', 'E305', 'E402', 'C0103', 'W0104', 'W0621', 'W391', 'W503', 'W504'},
                maxLineLength = 120,
              },
            },
          },
        },
      },
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
  setup = {
    ruff_lsp = function()
      require("lazyvim.util").lsp.on_attach(function(client, _)
        if client.name == "ruff_lsp" then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end)
    end,
  },
}
