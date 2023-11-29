local Util = require("lazyvim.util")
return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make CC=~/nvim-hacks/gcc",
    enabled = vim.fn.executable("make") == 1,
    config = function()
      Util.on_load("telescope.nvim", function()
        require("telescope").load_extension("fzf")
      end)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git",
          "venv",
        },
      },
      pickers = {
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    }
  }
}
