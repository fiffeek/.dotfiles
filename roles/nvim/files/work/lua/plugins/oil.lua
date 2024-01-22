return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
      },
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("oil").open()
        end,
        desc = "Explorer Oil",
      },
      {
        "-",
        "<CMD>Oil<CR>",
        desc = "Open parent dir",
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
