return {
  {
    "rgroli/other.nvim",
    enabled = true,
    lazy = false,
    config = function()
      require("other-nvim").setup(
        {
          -- do not preserve last choice, always ask
          rememberBuffers = false,
          mappings = {
            -- python general
            {
              pattern = "(.*)/(.*).py$",
              target = "%1/tests/test_%2.py",
              context = "test",
            },
            {
              pattern = "(.*)/tests/test_(.*).py$",
              target = "%1/%2.py",
              context = "file",
            },

            -- ddd specific
            {
              pattern = "(.*)/services/(.*)/internal/(.*).py$",
              target = "%1/services/%2/internal/domain",
              context = "domain",
            },
            {
              pattern = "(.*)/services/(.*)/internal/(.*).py$",
              target = "%1/services/%2/api",
              context = "api",
            },
          },
          style = {
            border = "rounded",
            seperator = "|",
            width = 0.9,
          }
        }
      )
    end,
    keys = {
      {
        "<leader>o",
        "<cmd>Other<cr>",
        desc = "Other",
      },
      {
        "<leader>ot",
        "<cmd>Other test<cr>",
        desc = "Other test",
      },
      {
        "<leader>of",
        "<cmd>Other file<cr>",
        desc = "Other file, back from X",
      },
      {
        "<leader>od",
        "<cmd>Other domain<cr>",
        desc = "Other domain",
      },
      {
        "<leader>oa",
        "<cmd>Other api<cr>",
        desc = "Other API",
      },
    },
  },
}
